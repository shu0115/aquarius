class RankVote < ActiveRecord::Base
  belongs_to :selection

  private
  #------------------#
  # self.create_vote #
  #------------------#
  # param_vote : 投票パラメータ
  # user_id : ユーザID
  def self.create_vote( param_vote, user_id )
    vote_notice = ""  # 投票メッセージ
    rank_hash = Hash.new  # 順位ハッシュ
    rank_count = 0  # 順位カウント

    param_vote.each_with_index{ |data, index|
      split_array = data[0].split("_")
      if split_array[0] == "rank"
        # 順位ハッシュに格納(key：selection_id／value：rank)
        rank_hash[split_array[1]] = data[1].to_i
        
        # 順位をカウント
        rank_count += data[1].to_i
      end
    }

    # 順位の合計が0以下であれば
    if rank_count <= 0
      return "順位を指定して下さい。<br /><br />"
    end

    # 順位昇順ソート
    rank_hash = rank_hash.sort{ |a, b| a[1] <=> b[1] }

    rank_hash.each_with_index{ |rank, index|
      # 既存投票データ取得
      vote = self.first( :conditions => { :selection_id => rank[0], :user_id => user_id, :election_id => param_vote[:election_id] } )

      unless vote.blank?
        # 順位格納
        vote.rank = (index + 1)
      else
        # 新規データ生成
        vote = self.new( :election_id => param_vote[:election_id], :selection_id => rank[0], :rank => (index + 1), :user_id => user_id )
      end

      # データ保存
      unless vote.save
        return "投票に失敗しました。<br /><br />"
      end
    }

    return "投票が完了しました。<br /><br />"
  end  

  #------------------#
  # self.delete_vote #
  #------------------#
  def self.delete_vote( param_vote, user_id )
    # 既存投票データ全削除
    result = self.destroy_all( :user_id => user_id, :election_id => param_vote[:election_id] )

    # 投票リセット
    if result.length >= 0
      return "投票をリセットしました。<br /><br />"
    else
      return "投票のリセットに失敗しました。<br /><br />"
    end
  end

end
