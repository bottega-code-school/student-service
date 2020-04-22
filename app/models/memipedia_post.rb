class MemipediaPost < ApplicationRecord
  belongs_to :client
  belongs_to :memipedia_user, optional: true

  validates_presence_of :name, :content

  has_one_attached :post_image
  validates :post_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  include PgSearch::Model
  pg_search_scope :search_by_term,
    against: [:name, :content],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

  def post_image_url
    if self.post_image.attachment
      self.post_image.attachment.service_url
    end
  end

  def column_names_merged_with_images
    MemipediaPost.column_names
      .select { |column| !['client_id'].include?(column) }
      .push(['id', 'name', 'content', 'post_image', 'created_at'])
      .flatten
      .uniq
  end
end
