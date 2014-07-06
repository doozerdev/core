class ItemController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.where(:parent=> nil)
    respond_to do |format|
      format.html
    end
  end

  #GET /lists/1
  def show
  end


  # new.html.erb
  def new
    @item = Item.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @item = Item.new(params.require(:item).permit(:title, :parent))
    respond_to do |format|
      if @item.save
        if @item.parent
          #redirect to parent list
          format.html { redirect_to Item.find(@item.parent), notice: 'Item was successfully created.' }
        else
          format.html { redirect_to items_path, notice: 'Item was successfully created.' }
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @item.children.each do |child|
      child.destroy
    end
    
    @item.destroy
    respond_to do |format|
      format.html { redirect_to  :back, notice: 'Item was successfully deleted.' }
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
