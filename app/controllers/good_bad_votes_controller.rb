class GoodBadVotesController < ApplicationController
  # GET /good_bad_votes
  # GET /good_bad_votes.xml
  def index
    @good_bad_votes = GoodBadVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @good_bad_votes }
    end
  end

  # GET /good_bad_votes/1
  # GET /good_bad_votes/1.xml
  def show
    @good_bad_vote = GoodBadVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @good_bad_vote }
    end
  end

  # GET /good_bad_votes/new
  # GET /good_bad_votes/new.xml
  def new
    @good_bad_vote = GoodBadVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @good_bad_vote }
    end
  end

  # GET /good_bad_votes/1/edit
  def edit
    @good_bad_vote = GoodBadVote.find(params[:id])
  end

  # POST /good_bad_votes
  # POST /good_bad_votes.xml
  def create
    @good_bad_vote = GoodBadVote.new(params[:good_bad_vote])

    respond_to do |format|
      if @good_bad_vote.save
        format.html { redirect_to(@good_bad_vote, :notice => 'GoodBadVote was successfully created.') }
        format.xml  { render :xml => @good_bad_vote, :status => :created, :location => @good_bad_vote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @good_bad_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /good_bad_votes/1
  # PUT /good_bad_votes/1.xml
  def update
    @good_bad_vote = GoodBadVote.find(params[:id])

    respond_to do |format|
      if @good_bad_vote.update_attributes(params[:good_bad_vote])
        format.html { redirect_to(@good_bad_vote, :notice => 'GoodBadVote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @good_bad_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /good_bad_votes/1
  # DELETE /good_bad_votes/1.xml
  def destroy
    @good_bad_vote = GoodBadVote.find(params[:id])
    @good_bad_vote.destroy

    respond_to do |format|
      format.html { redirect_to(good_bad_votes_url) }
      format.xml  { head :ok }
    end
  end
end
