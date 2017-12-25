class User < ApplicationRecord
  	extend Devise::Models

  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :posts, foreign_key: "author_id"

    has_attached_file :img, styles: {large: "480x480>", medium: "240x240>", thumb: "160x160>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
    validates :img_file_name, uniqueness: true
end
