class Client < ApplicationRecord
  has_secure_password

  validates :subdomain, format: { with: /\A[a-zA-Z0-9]+\Z/ }, presence: true, uniqueness: true
  validates :email, email: true, presence: true

  validates_presence_of :password_digest

  has_many :client_domains, dependent: :destroy

  has_many :portfolio_users, dependent: :destroy
  has_many :portfolio_items, dependent: :destroy
  has_many :portfolio_blogs, dependent: :destroy

  has_many :devworkflow_check_list_items, dependent: :destroy
  has_many :devworkflow_projects, dependent: :destroy
  has_many :devworkflow_project_line_items, dependent: :destroy
  has_many :devworkflow_users, dependent: :destroy

  has_many :memipedia_users, dependent: :destroy
  has_many :memipedia_posts, dependent: :destroy
end
