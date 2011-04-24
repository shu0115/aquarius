class ElectionsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @elections = Election.paginate( :conditions => { :user_id => session[:user_id] }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #------#
  # show #
  #------#
  def show
    @election = Election.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
  end

  #-----#
  # new #
  #-----#
  def new
    @election = Election.new
  end

  #------#
  # edit #
  #------#
  def edit
    @election = Election.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
  end

  #--------#
  # create #
  #--------#
  def create
    @election = Election.new( params[:election] )
    @election.user_id = session[:user_id]

    if @election.save
      redirect_to :action => "index" and return
    else
      render :action => "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @election = Election.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    if @election.update_attributes( params[:election] )
      redirect_to :action => "index", :page => params[:page] and return
    else
      render :action => "edit"
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @election = Election.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    redirect_to :action => "index" and return if @election.blank?

    unless @election.destroy
      flash[:notice] = "選挙の削除に失敗しました。"
    end
    
    redirect_to :action => "index", :page => params[:page] and return
  end

end
