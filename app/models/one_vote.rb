class OneVote < ActiveRecord::Base

  #-------------#
  # update_vote #
  #-------------#
  def update_vote( vote )
    if self.update_attributes( vote )
      selection = Selection.find_by_id( self.selection_id )
      vote_notice = "「#{selection.name}」に投票しました。<br /><br />" unless selection.blank?
    else
      vote_notice = "投票に失敗しました。<br /><br />"
    end

    return vote_notice
  end

  private
  #------------------#
  # self.create_vote #
  #------------------#
  def self.create_vote( vote, user_id )
    new_vote = self.new( vote )

    unless new_vote.selection_id.blank?
      new_vote.user_id = user_id
      
      if new_vote.save
        selection = Selection.find_by_id( new_vote.selection_id )
        vote_notice = "「#{selection.name}」に投票しました。<br /><br />" unless selection.blank?
      else
        vote_notice = "投票に失敗しました。<br /><br />"
      end
    else
      vote_notice = "候補者を選択して下さい。<br /><br />"
    end

#    return vote_notice, new_vote
    return vote_notice
  end

end
