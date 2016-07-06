class Profile < ActiveRecord::Base
  belongs_to :user
  has_attachment :photo

  after_save :sync_datas

  def sync_datas
    self.user.update_attribute(:first_name, self.first_name) if self.first_name != self.user.first_name
    self.user.update_attribute(:last_name, self.last_name) if self.last_name != self.user.last_name
  end
end
