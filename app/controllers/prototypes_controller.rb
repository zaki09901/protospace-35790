class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  #authenticate_user! ログイン済みのユーザーのみアクセスを許可する <=> ログインしていないユーザーでもできること・・・index,show

  before_action :move_to_index, except: [:show, :index, :new, :create, :update]      #except: [:index, :show, :update, :destroy, :create]
  
  def index
    @prototypes = Prototype.all
    end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end 

  def  edit
    @prototype = Prototype.find(params[:id])
  end  

  def  update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path

  end

  def create
    @prototype =Prototype.new(prototype_params)
    #create = new,save
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless   @prototype.user_id == current_user.id
      redirect_to action: :index
    end
  end

end
