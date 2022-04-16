class BookSerializer < ActiveModel::Serializer
  attributes  :title, :author, :published_at
  
  def id
    object.title[-1] 
  end
  def author
    {name: object.author.first_name + " " + object.author.last_name,
     age: object.author.age}
  end

end
