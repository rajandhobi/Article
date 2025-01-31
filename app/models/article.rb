class Article < ApplicationRecord
    has_many :comments ,dependent: :destroy
    belongs_to :user # Associates Article with User

    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }
    has_one_attached :image do |attachable|
      attachable.variant :thumb,resize_to_fill: [400,300]
    end

    has_one_attached :video do |attachable|
      attachable.variant :thumb,resize_to_limit: [500,500], preprocessed: true
    end

    # has_many_attached :images do |attachable|
    #   attachable.variant :thumb, resize_to_limit: [nil,300]
    # end

    has_many_attached :documents

    def self.ransackable_attributes(auth_object = nil)
      ["body", "created_at", "id", "title", "updated_at"]
    end
  
  end
  