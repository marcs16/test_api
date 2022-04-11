class Book < ApplicationRecord
    validates :author, presence: true, length: { minimum: 3 }
    validates :title, presence: true, length: { minimum: 3 }
    validates :published_at, presence: true, numericality: { greater_than: 0 }
end
