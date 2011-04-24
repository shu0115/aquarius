class GoodBadVote < ActiveRecord::Base

  private
  #------------------#
  # self.create_vote #
  #------------------#
  # param_vote : 投票パラメータ
  # user_id : ユーザID
  def self.create_vote( param_vote, user_id )
    vote_notice = ""  # 投票メッセージ

    # 既存投票データ取得
    exist_votes = self.all( :conditions => { :user_id => user_id, :election_id => param_vote[:election_id] } )

    # 既存データがブランクでなければ
    unless exist_votes.blank?
      exist_votes.each{ |vote|
        if param_vote[:choice].blank? or param_vote[:choice][vote.selection_id.to_s].blank?
          choice = "none"
        else
          # 投票パラメータを格納
          choice = param_vote[:choice][vote.selection_id.to_s]
        end

        # 更新
        unless vote.update_attributes( :choice => choice )
          return "投票に失敗しました。<br /><br />"
        end
      }
    else
      param_vote[:choice].each{ |choice|
        # 新規データ生成
        new_vote = self.new( :election_id => param_vote[:election_id], :selection_id => choice[0], :choice => choice[1], :user_id => user_id )
        
        # 新規データ保存
        unless new_vote.save
          return "投票に失敗しました。<br /><br />"
        end
      }
    end

    return "投票が完了しました。<br /><br />"
  end  

end
