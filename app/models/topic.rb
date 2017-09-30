class Topic < ActiveRecord::Base
    validates  :content, presence: true
    belongs_to :user
    
    #mount_uploader :image, ImageUploader
end
