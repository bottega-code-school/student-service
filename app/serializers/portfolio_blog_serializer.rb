class PortfolioBlogSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :blog_status,
             :featured_image_url,
             :column_names_merged_with_images
end
