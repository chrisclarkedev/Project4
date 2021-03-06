class CollectsController < ApplicationController
  def index
    @collects = Collect.all
    render json: @collects, include: :sneakers, status: :ok
  end

  def show
    @collect = Collect.find(params[:id])
    render json: @collect
  end

  def create
    # if params[:sneaker_id]
    #   @sneaker = Sneaker.find(params[:sneaker_id])

    # else
      @collect = Collect.new(collect_params)
      if @collect.save
        render json: @collect, status: :created
      else
        render json:{ errors: @collect.errors }, status: :unprocessable_entity
      end
    # end
  end

  def update
    @collect = Collect.find(params[:id])
    if @collect.update(collect_params)
      render json: @collect
    else
      render json: { errors: @collect.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @collect = Collect.find(params[:id])
    @collect.destroy
    head 204
  end

  private

  def collect_params
    params.require(:collect).permit(:name, :brand, :description, :review, :imgurl, :price, :sneakers)
  end
end