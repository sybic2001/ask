class Profile < ActiveRecord::Base
  belongs_to :user
  has_attachment :photo

  after_save :sync_datas
  LOCALES = ["en", "fr"]

  def sync_datas
    self.user.update_attribute(:first_name, self.first_name) if self.first_name != self.user.first_name
    self.user.update_attribute(:last_name, self.last_name) if self.last_name != self.user.last_name
  end

  def complete?
    return !self.address.blank? && !self.phone_number.blank? && !self.city.blank? && !self.description.blank? &&self.photo?
  end
end
