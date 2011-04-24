class ThreeVote < ActiveRecord::Base

  private
  #------------------#
  # self.update_vote #
  #------------------#
  def self.update_vote( vote, three_votes )
    vote_notice = ""
    vote_index = 0
    selection_name_array = Array.new

    # 更新処理
    vote[:selection_id].each_pair{ |key, value|
      if key == value
        vote = three_votes[vote_index]

        if vote.update_attributes( :selection_id => value )
          selection = Selection.find_by_id( vote.selection_id )
          selection_name_array.push( selection.name ) unless selection.blank?
          vote_index += 1
        else
          return "投票に失敗しました。<br /><br />"
        end
      end
    }

    # 名前順ソート
    selection_name_array.sort.each{ |name|
      vote_notice += "「#{name}」"
    }
    vote_notice += "に投票しました。<br /><br />"

    return vote_notice
  end

  #------------------#
  # self.create_vote #
  #------------------#
  def self.create_vote( vote, user_id )
    vote_notice = ""

    # 候補名配列
    selection_name_array = Array.new

    vote[:selection_id].each_pair{ |key, value|
      if key == value
        new_vote = self.new( :election_id => vote[:election_id], :selection_id => value )
        new_vote.user_id = user_id

        if new_vote.save
          selection = Selection.find_by_id( new_vote.selection_id )
          selection_name_array.push( selection.name ) unless selection.blank?
        else
          return "投票に失敗しました。<br /><br />"
        end
      end
    }

    # 名前順ソート
    selection_name_array.sort.each{ |name|
      vote_notice += "「#{name}」"
    }
    vote_notice += "に投票しました。<br /><br />"

    return vote_notice
  end

end
