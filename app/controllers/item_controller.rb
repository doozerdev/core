class ItemController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_authN
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_authZ, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.where(:user_id => current_user.id.to_s)
    respond_to do |format|
      format.html
      format.json
    end
  end

  #GET /lists/1
  def show
      respond_to do |format|
        format.html
        format.json 
          @json = { :item => @item, :children => @item.children }.to_json
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
    @item = Item.new(params.require(:item).permit(:title, :parent))
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.save
        if @item.parent
          #redirect to parent list
          format.html { redirect_to Item.find(@item.parent), notice: 'Item was successfully created.' }
        else
          format.html { redirect_to items_path, notice: "Item was successfully created. #{@item.user_id}" }
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
      format.html { redirect_to :back, notice: 'Item was successfully deleted.' }
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
