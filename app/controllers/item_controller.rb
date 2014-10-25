class ItemController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_authN
  before_action :set_item, only: [:show, :update, :move_up, :move_down, :toggle, :edit, :update, :destroy]
  before_action :check_authZ, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.where(:user_id => current_user.id.to_s, :parent => nil)
    respond_to do |format|
      format.html
      format.json
    end
  end

  #GET /lists/1
  def show
    #fix up existing lists, so they can be reordered if they don't have an existing order value
    @item.reorder_list if @item.children.any?{|i| i.order.nil? }

      respond_to do |format|
        format.html
        format.json 
          @json = { :item => @item, :children => @item.children }.to_json
      end
  end


  def toggle
    respond_to do |format|
      @item.done = params[:done] == 'true'
      if @item.save
        format.html { render :results => 'Item saved.' }
        format.js { render :data => "we good!", :status => :ok }
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end

  def update
    respond_to do |format|
      @item.done = params[item.id.to_s] == 'true'
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item saved.') }
        format.js
      else
        format.html { render :action => "new" }
        format.js
      end
    end
  end

  # new.html.erb
  def new
    @item = Item.new
    respond_to do |format|
      format.html
    end
  end

  def create
    #TODO, check if we're over the max number of supported items per list.
    #very unlikely, considering we're supporting Int32Max
    @item = Item.new(params.require(:item).permit(:title, :parent))
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.parent
        if Item.find(@item.parent).insert_tail(@item)
          #redirect to parent list
          format.html { redirect_to Item.find(@item.parent)}
        else
          format.html { render action: "new", notice: 'There was a problem creating the item, please try again.' }
        end
      else
        if @item.save
          format.html { redirect_to @item, notice: "List was successfully created, start adding items!" }
        else
          format.html { render action: "new" }
        end
      end
    end
  end

  def move_up
    parent = Item.find(@item.parent)

    if parent.children.index(@item) >= 1
      before = parent.children[parent.children.index(@item)-1]
      parent.insert_before(before, @item)
    end

    respond_to do |format|
      format.html { redirect_to Item.find(@item.parent)}
    end
  end

  def move_down
    parent = Item.find(@item.parent)

    if parent.children.index(@item)+1 < parent.children.count
      after = parent.children[parent.children.index(@item)+1]
      parent.insert_after(after, @item)
    end

    respond_to do |format|
      format.html { redirect_to Item.find(@item.parent)}
    end
  end

  def destroy
    @item.children.each do |child|
      child.destroy
    end
    parent = Item.find(@item.parent)
    @item.destroy


    respond_to do |format|
      if @item.parent
        format.html  { redirect_to parent }
      else
        format.html  { redirect_to :back }
      end
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def check_authN
      redirect_to root_path, notice: 'Please login first' unless current_user
  end

  def check_authZ
    if @item
      redirect_to root_path, notice: 'You are not authorized to do that' unless @item.user_id == current_user.id.to_s
    end
  end
end
