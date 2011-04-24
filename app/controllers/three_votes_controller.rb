class ThreeVotesController < ApplicationController
  # GET /three_votes
  # GET /three_votes.xml
  def index
    @three_votes = ThreeVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @three_votes }
    end
  end

  # GET /three_votes/1
  # GET /three_votes/1.xml
  def show
    @three_vote = ThreeVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @three_vote }
    end
  end

  # GET /three_votes/new
  # GET /three_votes/new.xml
  def new
    @three_vote = ThreeVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @three_vote }
    end
  end

  # GET /three_votes/1/edit
  def edit
    @three_vote = ThreeVote.find(params[:id])
  end

  # POST /three_votes
  # POST /three_votes.xml
  def create
    @three_vote = ThreeVote.new(params[:three_vote])

    respond_to do |format|
      if @three_vote.save
        format.html { redirect_to(@three_vote, :notice => 'ThreeVote was successfully created.') }
        format.xml  { render :xml => @three_vote, :status => :created, :location => @three_vote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @three_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /three_votes/1
  # PUT /three_votes/1.xml
  def update
    @three_vote = ThreeVote.find(params[:id])

    respond_to do |format|
      if @three_vote.update_attributes(params[:three_vote])
        format.html { redirect_to(@three_vote, :notice => 'ThreeVote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @three_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /three_votes/1
  # DELETE /three_votes/1.xml
  def destroy
    @three_vote = ThreeVote.find(params[:id])
    @three_vote.destroy

    respond_to do |format|
      format.html { redirect_to(three_votes_url) }
      format.xml  { head :ok }
    end
  end
end
