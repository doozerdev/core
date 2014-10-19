class Item
  include MongoMapper::Document

  key :title, String
  key :done, Boolean
  key :parent, String
  key :order, Integer
  key :duedate, DateTime
  key :user_id, String
  key :notes, String

  def children
    Item.where(:parent => id.to_s).order(:order)
  end

end
