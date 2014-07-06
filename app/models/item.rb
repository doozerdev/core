class Item
  include MongoMapper::Document

  key :title, String
  key :done, Boolean
  key :parent, String
  key :order, Float
  key :duedate, DateTime

  def children
    Item.where(:parent => id.to_s).all
  end
end
