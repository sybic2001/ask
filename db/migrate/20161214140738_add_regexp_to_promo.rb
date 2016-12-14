class AddRegexpToPromo < ActiveRecord::Migration
  def change
    add_column :communities, :promo_format, :string
  end
end
