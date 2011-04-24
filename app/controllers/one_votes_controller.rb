class OneVotesController < ApplicationController
  # GET /one_votes
  # GET /one_votes.xml
  def index
    @one_votes = OneVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @one_votes }
    end
  end

  # GET /one_votes/1
  # GET /one_votes/1.xml
  def show
    @one_vote = OneVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @one_vote }
    end
  end

  # GET /one_votes/new
  # GET /one_votes/new.xml
  def new
    @one_vote = OneVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @one_vote }
    end
  end

  # GET /one_votes/1/edit
  def edit
    @one_vote = OneVote.find(params[:id])
  end

  # POST /one_votes
  # POST /one_votes.xml
  def create
    @one_vote = OneVote.new(params[:one_vote])

    respond_to do |format|
      if @one_vote.save
        format.html { redirect_to(@one_vote, :notice => 'OneVote was successfully created.') }
        format.xml  { render :xml => @one_vote, :status => :created, :location => @one_vote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @one_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /one_votes/1
  # PUT /one_votes/1.xml
  def update
    @one_vote = OneVote.find(params[:id])

    respond_to do |format|
      if @one_vote.update_attributes(params[:one_vote])
        format.html { redirect_to(@one_vote, :notice => 'OneVote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @one_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /one_votes/1
  # DELETE /one_votes/1.xml
  def destroy
    @one_vote = OneVote.find(params[:id])
    @one_vote.destroy

    respond_to do |format|
      format.html { redirect_to(one_votes_url) }
      format.xml  { head :ok }
    end
  end
end
