class RankVotesController < ApplicationController
  # GET /rank_votes
  # GET /rank_votes.xml
  def index
    @rank_votes = RankVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rank_votes }
    end
  end

  # GET /rank_votes/1
  # GET /rank_votes/1.xml
  def show
    @rank_vote = RankVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rank_vote }
    end
  end

  # GET /rank_votes/new
  # GET /rank_votes/new.xml
  def new
    @rank_vote = RankVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rank_vote }
    end
  end

  # GET /rank_votes/1/edit
  def edit
    @rank_vote = RankVote.find(params[:id])
  end

  # POST /rank_votes
  # POST /rank_votes.xml
  def create
    @rank_vote = RankVote.new(params[:rank_vote])

    respond_to do |format|
      if @rank_vote.save
        format.html { redirect_to(@rank_vote, :notice => 'RankVote was successfully created.') }
        format.xml  { render :xml => @rank_vote, :status => :created, :location => @rank_vote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rank_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rank_votes/1
  # PUT /rank_votes/1.xml
  def update
    @rank_vote = RankVote.find(params[:id])

    respond_to do |format|
      if @rank_vote.update_attributes(params[:rank_vote])
        format.html { redirect_to(@rank_vote, :notice => 'RankVote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rank_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rank_votes/1
  # DELETE /rank_votes/1.xml
  def destroy
    @rank_vote = RankVote.find(params[:id])
    @rank_vote.destroy

    respond_to do |format|
      format.html { redirect_to(rank_votes_url) }
      format.xml  { head :ok }
    end
  end
end
