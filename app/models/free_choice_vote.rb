class FreeChoiceVote < ActiveRecord::Base

  private
  #------------------#
  # self.create_vote #
  #------------------#
  # param_vote : 投票パラメータ
  # user_id : ユーザID
  def self.create_vote( param_vote, user_id )
    vote_notice = ""  # 投票メッセージ
    selection_name_array = Array.new  # 候補名配列

    choice_count = 0
    param_vote[:selection_id].each_value{ |value| unless value.blank?; choice_count += 1; end; }

    # 既存投票データ全削除
    result = self.destroy_all( :user_id => user_id, :election_id => param_vote[:election_id] )

    # 投票リセット
    if choice_count == 0
      if result.length >= 0
        return "投票をリセットしました。<br /><br />"
      else
        return "投票のリセットに失敗しました。<br /><br />"
      end
    else
      param_vote[:selection_id].each_pair{ |key, value|
        # チェックボックスにチェックがあれば
        if key == value
          # 投票データ新規作成
          new_vote = self.new( :election_id => param_vote[:election_id], :selection_id => value, :user_id => user_id )
          
          # 投票データ保存
          if new_vote.save
            # 候補データ取得
            selection = Selection.find_by_id( new_vote.selection_id )
            # 候補名格納
            selection_name_array.push( selection.name ) unless selection.blank?
          else
            return "投票に失敗しました。<br /><br />"
          end
        end
      }
      
      # 名前順ソート
      selection_name_array.sort.each{ |name| vote_notice += "「#{name}」" }
      vote_notice += "に投票しました。<br /><br />"
    end

    return vote_notice
  end  

end
