class AddAuthorToMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :author_id, :integer
    add_column :messages, :sender_id, :integer
    add_column :messages, :receiver_id, :integer
  end
end
