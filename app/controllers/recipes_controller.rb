class RecipesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      track_activity @recipe
      current_user.activities.redirect_to @recipe, notice: "Recipe was created."
    else
      render :new
    end
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def update
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      track_activity @recipe
      redirect_to @recipe, notice: "Recipe was updated."
    else
      render :edit
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    track_activity @recipe
    redirect_to recipes_url, notice: "Recipe was destroyed."
  end

  private
  def recipe_params
    params.require(:recipe).permit(:description, :image_url, :name)
  end
end
