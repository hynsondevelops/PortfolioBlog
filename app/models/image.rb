class Image < ApplicationRecord
	has_attached_file :img, styles: {large: "800x800>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
	validates :img_file_name, uniqueness: true
end
