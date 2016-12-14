class ChangePromotionToInteger < ActiveRecord::Migration
  def change
    change_column :memberships, :promotion, 'integer USING CAST (promotion AS integer)'
  end
end
