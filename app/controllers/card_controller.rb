class CardController < ApplicationController
  before_action :set_card, only: %i(show edit update destroy)

  def new
    @card = Card.new
    @list = List.find(params[:list_id])
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to :root
    else
      @card.valid?
      render :new
    end
  end

  def show
  end

  def edit
    # ここに追加
    @lists = List.where(user: current_user)
  end

  def update
    if @card.update_attributes(card_params)
      redirect_to :root
    else
      render action: :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to :root
  end

  private
    def card_params
      params.require(:card).permit(:title, :memo).merge(list_id: params[:list_id])
    end

    def set_card
      @card = Card.find(params[:id])
    end
end
