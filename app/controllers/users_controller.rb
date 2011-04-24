class UsersController < ApplicationController

  before_filter :level_master_check

  #-------#
  # index #
  #-------#
  def index
    @users = User.paginate( :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #------#
  # show #
  #------#
  def show
    @user = User.find(params[:id])
  end

  #-----#
  # new #
  #-----#
  def new
    @user = User.new
  end

  #------#
  # edit #
  #------#
  def edit
    @user = User.find(params[:id])
  end

  #--------#
  # create #
  #--------#
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to(@user, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @user = User.find(params[:id])

    # パスワードチェックがtrueで無ければ
    unless @user.password_check?( params[:user][:password] )
      flash[:notice] = "「現在のパスワード」が正しくありません。<br />"
      redirect_to :action => "edit" and return
    end

    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => "ユーザ情報を更新しました。<br /><br />")
    else
      render :action => "edit"
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to(users_url)
  end

  private
  #--------------------#
  # level_master_check #
  #--------------------#
  def level_master_check
    unless User.level_master?( session[:user_id] )
      # セッション情報クリア
      user_session_clear
      flash[:login_notice] = "権限がありません。<br /><br />"
      redirect_to :controller => "entry", :action => "login" and return
    end    
  end

end