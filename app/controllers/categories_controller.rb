class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.order(:name)
  end

  def show
    @posts = @category.posts
  end

  def new
    @category = Category.new(color: "blue")
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "カテゴリを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "カテゴリを更新しました。", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_path, notice: "カテゴリを削除しました。", status: :see_other
  end

  private

  def set_category
    @category = Category.find(params.expect(:id))
  end

  def category_params
    params.expect(category: [ :name, :color ])
  end
end
