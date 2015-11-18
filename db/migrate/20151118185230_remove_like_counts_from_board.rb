class RemoveLikeCountsFromBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :like_counts, :integer
  end
end
