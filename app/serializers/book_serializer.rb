class BookSerializer < ActiveModel::Serializer
  attributes :title, :author, :published_at
   
  def author
    {name: object.author.first_name + " " + object.author.last_name,
     age: object.author.age}
  end

end
