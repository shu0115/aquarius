class EntryController < ApplicationController

  skip_filter :authorize, :only => [ :login, :input, :complete ]

  #-------#
  # input #
  #-------#
  def input
    if params[:commit] == "確認"
      @user = User.new( params[:user] )
      if @user.valid?
        render :action => "confirmation"
      end
    else
      @user = User.new( params[:user] )
    end
  end

  #----------#
  # complete #
  #----------#
  def complete
    @user = User.new( params[:user] )

    if @user.save
      flash[:notice] = 'ユーザ登録が完了しました。<br /><br />'
      # ユーザ情報をセッションに格納
      user_session_set( @user )
      redirect_to :root and return
    else
      flash[:notice] = 'Error.'
      render :action => "input"
    end
  end

  #-------#
  # login #
  #-------#
  def login
    @user = User.new( params[:login] )

    return if @user.blank?

    if !@user.login_id.blank? and !@user.password.blank?
      # ユーザ認証
      user = @user.authenticate

      unless user.blank?
        # ユーザ情報をセッションに格納
        user_session_set( user )

        unless session[:request_url].blank?
          redirect_to session[:request_url]
          session[:request_url] = nil
          return
        else
          redirect_to :root and return
        end
      else
        flash[:notice] = "ログインIDもしくはパスワードが正しくありません。"
      end
    end
  end

  #--------#
  # logout #
  #--------#
  def logout
    user_session_clear

    redirect_to :controller => "entry", :action => "login" and return
#    redirect_to :controller => "public" and return
  end

  #------#
  # show #
  #------#
  def show
    @user = User.find_by_id( session[:user_id] )
  end

  #------#
  # edit #
  #------#
  def edit
    @user = User.find_by_id( session[:user_id] )
  end

  #--------#
  # update #
  #--------#
  def update
    @user = User.find_by_id( session[:user_id] )

    if params[:user].blank?
      flash[:notice] = "ユーザ情報がありません。<br /><br />"
      redirect_to :action => "edit" and return
    end

    # パスワードチェックがtrueで無ければ
    unless @user.password_check?( params[:user][:password] )
      flash[:notice] = "「現在のパスワード」が正しくありません。<br /><br />"
      redirect_to :action => "edit" and return
    end

    if !params[:user][:edit_password].blank? and !params[:user][:edit_password_confirmation].blank?
      # 変更するパスワードと再入力パスワードが一致しなければ
      unless params[:user][:edit_password] == params[:user][:edit_password_confirmation]
        flash[:notice] = "「変更するパスワード」と「変更するパスワード(再入力)」が一致しません。<br /><br />"
        redirect_to :action => "edit" and return
      else
        # パスワード更新
        params[:user][:password] = params[:user][:edit_password]
      end
    end

    # ユーザ情報を更新
    if @user.update_attributes( params[:user] )
      flash[:notice] = "ユーザ情報を更新しました。<br /><br />"
      user_session_set( @user )
      redirect_to :action => "show" and return
    else
      flash[:notice] = "ユーザ情報の更新に失敗しました。<br /><br />"
      redirect_to :action => "edit" and return
    end
  end
  
  #---------------#
  # edit_password #
  #---------------#
  def edit_password
    @user = User.find_by_id( session[:user_id] )
  end
  
  #-----------------#
  # update_password #
  #-----------------#
  def update_password
    @user = User.find_by_id( session[:user_id] )
    params_user = params[:user]
    
    if params_user.blank?
      flash[:notice] = "ユーザ情報がありません。<br /><br />"
      redirect_to :action => "edit_password", :id => @user.id and return
    end

    # パスワードチェックがtrueで無ければ
    unless @user.password_check?( params_user[:password] )
      flash[:notice] = "「現在のパスワード」が正しくありません。<br /><br />"
      redirect_to :action => "edit_password", :id => @user.id and return
    end
    
    # 変更するパスワードと再入力パスワードが一致しなければ
    unless params_user[:edit_password] == params_user[:password_confirmation]
      flash[:notice] = "「変更するパスワード」と「変更するパスワード(再入力)」が一致しません。<br /><br />"
      redirect_to :action => "edit_password", :id => @user.id and return
    end

    # パスワード更新
    params_user[:password] = params_user[:edit_password]

    # ユーザ情報を更新
    if @user.update_attributes( params_user )
      flash[:notice] = "パスワードを変更しました。<br /><br />"
      redirect_to :action => "show", :id => @user.id and return
    else
      flash[:notice] = "パスワードの変更に失敗しました。<br /><br />"
      redirect_to :action => "edit_password", :id => @user.id and return
    end
  end

end