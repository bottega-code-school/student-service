class PortfolioUser < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email, scope: :client_id

  belongs_to :client

  def can_modify_user?(user_id)
    id.to_s == user_id.to_s
  end

  def column_names_merged_with_images
    PortfolioUser.column_names
      .select { |column| !['client_id', 'password_digest', 'updated_at'].include?(column) }
      .push(['id', 'email', 'password', 'password_confirmation'])
      .flatten
      .uniq
  end
end
