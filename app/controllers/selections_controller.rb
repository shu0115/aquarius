class SelectionsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @selections = Selection.paginate( :conditions => { :user_id => session[:user_id], :election_id => params[:election_id] }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #------#
  # show #
  #------#
  def show
    @selection = Selection.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
  end

  #-----#
  # new #
  #-----#
  def new
    @selection = Selection.new
  end

  #------#
  # edit #
  #------#
  def edit
    @selection = Selection.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
  end

  #--------#
  # create #
  #--------#
  def create
    @selection = Selection.new( params[:selection] )
    @selection.user_id = session[:user_id]

    if @selection.save
      redirect_to :action => "index", :election_id => @selection.election_id, :page => params[:page], :election_page => params[:election_page] and return
    else
      render :action => "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @selection = Selection.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    if @selection.update_attributes( params[:selection] )
      redirect_to :action => "index", :election_id => @selection.election_id, :page => params[:page], :election_page => params[:election_page] and return
    else
      render :action => "edit"
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @selection = Selection.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    redirect_to :action => "index" and return if @selection.blank?

    unless @selection.destroy
      flash[:notice] = "候補の削除に失敗しました。"
    end
    
    redirect_to :action => "index", :election_id => @selection.election_id, :page => params[:page], :election_page => params[:election_page] and return
  end
end
