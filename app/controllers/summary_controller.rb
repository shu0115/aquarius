class SummaryController < ApplicationController
  
  skip_filter :authorize

  #-------#
  # index #
  #-------#
  def index
    @elections = Election.paginate( :conditions => { :mode => "public" }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #----------#
  # one_vote #
  #----------#
  def one_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @vote_count = Hash.new{ | hash, key | hash[key] = Hash.new }

    @selections.each{ |selection|
      # 候補名
      @vote_count[selection.id][:name] = selection.name
      
      # 投票数
      @vote_count[selection.id][:count] = OneVote.count( :conditions => { :selection_id => selection.id } )
    }

    # 名前順ソート
    @vote_count = @vote_count.sort{ |a, b| a[1][:name] <=> b[1][:name] }

    print "[ @vote_count ] : "; p @vote_count ;

    render params[:graph]
  end

  #------------#
  # three_vote #
  #------------#
  def three_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @vote_count = Hash.new{ | hash, key | hash[key] = Hash.new }

    @selections.each{ |selection|
      # 候補名
      @vote_count[selection.id][:name] = selection.name
      
      # 投票数
      @vote_count[selection.id][:count] = ThreeVote.count( :conditions => { :selection_id => selection.id } )
    }

    # 名前順ソート
    @vote_count = @vote_count.sort{ |a, b| a[1][:name] <=> b[1][:name] }

    print "[ @vote_count ] : "; p @vote_count ;

    render params[:graph]
  end

  #-----------#
  # rank_vote #
  #-----------#
  def rank_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @vote_count = Hash.new{ | hash, key | hash[key] = Hash.new }

    @selections.each{ |selection|
      # 候補名
      @vote_count[selection.id][:name] = selection.name
      
      # 投票数
      1.upto(@selections.length){ |index|
        print "[ index ] : "; p index ;
        @vote_count[selection.id]["count_#{selection.id}_#{index}"] = RankVote.count( :conditions => { :selection_id => selection.id, :rank => index } )
      }
    }

    # 名前順ソート
    @vote_count = @vote_count.sort{ |a, b| a[1][:name] <=> b[1][:name] }

    print "[ @vote_count ] : "; p @vote_count ;

    if params[:graph] == "total" or params[:graph] == "bar_chart"
      render params[:graph]
    else
      params[:graph] = "total"
      render "total"
    end
  end

  #------------------#
  # free_choice_vote #
  #------------------#
  def free_choice_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @vote_count = Hash.new{ | hash, key | hash[key] = Hash.new }

    @selections.each{ |selection|
      # 候補名
      @vote_count[selection.id][:name] = selection.name
      
      # 投票数
      @vote_count[selection.id][:count] = FreeChoiceVote.count( :conditions => { :selection_id => selection.id } )
    }

    # 名前順ソート
    @vote_count = @vote_count.sort{ |a, b| a[1][:name] <=> b[1][:name] }

    print "[ @vote_count ] : "; p @vote_count ;

    render params[:graph]
  end

  #---------------#
  # good_bad_vote #
  #---------------#
  def good_bad_vote
    @election = Election.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if @election.blank?

    @selections = Selection.all( :conditions => { :election_id => @election.id } )

    @vote_count = Hash.new{ | hash, key | hash[key] = Hash.new }

    @selections.each{ |selection|
      # 候補名
      @vote_count[selection.id][:name] = selection.name
      
      # 投票数(Good)
      @vote_count[selection.id][:good_count] = GoodBadVote.count( :conditions => { :selection_id => selection.id, :choice => "good" } )
      
      # 投票数(Bad)
      @vote_count[selection.id][:bad_count] = GoodBadVote.count( :conditions => { :selection_id => selection.id, :choice => "bad" } )
    }

    # 名前順ソート
    @vote_count = @vote_count.sort{ |a, b| a[1][:name] <=> b[1][:name] }

    print "[ @vote_count ] : "; p @vote_count ;

    render params[:graph]
  end

end
