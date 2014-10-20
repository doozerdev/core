class Item
  include MongoMapper::Document

  @@increment = 1024
  #Ruby automatically converts integers to a large integer class when they overflow, so there's (practically) no limit to how big they can be. We'll define a max here so we don't run into issues with Swift
  @@intMax = 2147483647 

  key :title, String
  key :done, Boolean
  key :parent, String
  key :order, Integer
  key :duedate, DateTime
  key :user_id, String
  key :notes, String

  def children
    #TODO: cache this
    child_items = Item.where(:parent => id.to_s).order(:order).all
  end

  def insert_tail(item)
    if children.count == 0 
      item.order = @@increment
    elsif children.last.order + @@increment < @@intMax
      item.order = children.last.order + @@increment
    else
      #reorder_list will return the increment used to equally distribute the items
      #item hasn't yet been saved, so it won't show up in children.count
      item.order = reorder_list * (children.count+1)
    end
    item.save
  end

  def insert_head(item)
    if children.count == 0
      item.order = @@increment
    elsif children.first.order/2 < 2
      item.order = children.first.order/2
    else
      item.order = 0
      #reorder_list will return the increment used to equally distribute the items
      item.order = reorder_list/2
    end
    item.save
  end

  def insert_after(after, item)
    if children.index(after) < children.count-1
      np2 = children[children.index(after)+1]
      np1 = children[children.index(after)]

      if (np2.order-np1.order)/2 > 2
        item.order = (np2.order-np1.order)/2 + np1.order
        item.save
      else
        item.order = np2.order - 1
        reorder_list
        item.save
      end

    else
      insert_tail(item)
    end
  end

  def insert_before(before, item)
    if children.index(before) >= 1
      nm2 = children[children.index(before)-1]
      nm1 = children[children.index(before)]

      if (nm1.order-nm2.order)/2 > 2
        item.order = (nm1.order-nm2.order)/2 + nm2.order
        item.save
      else
        item.order = nm1.order + 1
        reorder_list
        item.save
      end
    else
      insert_head(item)
    end
  end

  def reorder_list
    #check if we can just redistribute everything based on our standard increment
    
    children.count * @@increment < @@intMax ? 
      new_increment = @@increment : 
      new_increment = @@intMax/(children.count+1)

    order_val = 1
      children.each do |i|
        i.order = new_increment * order_val
        i.save
        order_val += 1
      end
    new_increment
  end

end
