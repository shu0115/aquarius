class FreeChoiceVotesController < ApplicationController
  # GET /free_choice_votes
  # GET /free_choice_votes.xml
  def index
    @free_choice_votes = FreeChoiceVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @free_choice_votes }
    end
  end

  # GET /free_choice_votes/1
  # GET /free_choice_votes/1.xml
  def show
    @free_choice_vote = FreeChoiceVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @free_choice_vote }
    end
  end

  # GET /free_choice_votes/new
  # GET /free_choice_votes/new.xml
  def new
    @free_choice_vote = FreeChoiceVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @free_choice_vote }
    end
  end

  # GET /free_choice_votes/1/edit
  def edit
    @free_choice_vote = FreeChoiceVote.find(params[:id])
  end

  # POST /free_choice_votes
  # POST /free_choice_votes.xml
  def create
    @free_choice_vote = FreeChoiceVote.new(params[:free_choice_vote])

    respond_to do |format|
      if @free_choice_vote.save
        format.html { redirect_to(@free_choice_vote, :notice => 'FreeChoiceVote was successfully created.') }
        format.xml  { render :xml => @free_choice_vote, :status => :created, :location => @free_choice_vote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @free_choice_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /free_choice_votes/1
  # PUT /free_choice_votes/1.xml
  def update
    @free_choice_vote = FreeChoiceVote.find(params[:id])

    respond_to do |format|
      if @free_choice_vote.update_attributes(params[:free_choice_vote])
        format.html { redirect_to(@free_choice_vote, :notice => 'FreeChoiceVote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @free_choice_vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /free_choice_votes/1
  # DELETE /free_choice_votes/1.xml
  def destroy
    @free_choice_vote = FreeChoiceVote.find(params[:id])
    @free_choice_vote.destroy

    respond_to do |format|
      format.html { redirect_to(free_choice_votes_url) }
      format.xml  { head :ok }
    end
  end
end
