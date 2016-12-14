class ChangePromoFormatToInteger < ActiveRecord::Migration
  def change
    change_column :communities, :promo_format, 'integer USING CAST (promo_format AS integer)'
  end
end
