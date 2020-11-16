class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_prototype, only[:show, :edit, :update, :destroy]
  # 上記は最終的にまとめるか決める。

    def index
      @prototypes = Prototype.includes(:user)
      # (@prototypes = Prototype.all)
    end


  def new
    @prototypes = Prototype.new
  end


  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end


  def show
    @prototype = Prototype.find(params[:id])
    
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end


  def edit
    @prototype = Prototype.find(params[:id])

    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end

  end


  def update
    @prototype = Prototype.find(params[:id])
   if @prototype.update(prototype_params)
    redirect_to prototype_path
   else
    render :edit
  end
end


def destroy
  prototype = Prototype.find(params[:id])
  if prototype.destroy
    redirect_to root_path
end
end




  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)

end

end
