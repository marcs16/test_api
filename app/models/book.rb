class Book < ApplicationRecord
    belongs_to :author
   
    validates :title, presence: true, length: { minimum: 3 }
    validates :published_at, presence: true, numericality: { greater_than: 0 }
end
