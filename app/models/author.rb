class Author < ApplicationRecord
    has_many :books

    validates :first_name, presence: true, length: { minimum: 3 }
    validates :last_name, presence: true, length: { minimum: 3 }
    validates :age, presence: true, numericality: { greater_than: 5 }

end
