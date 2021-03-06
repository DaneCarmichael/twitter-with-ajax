class DanesController < ApplicationController
  skip_before_action :authenticate_dane, only: [:show, :index, :new, :create]
  def index
    @danes = Dane.page(params[:page])
  end

  def show
    @dane = get_dane
  end

  def new
    @dane = Dane.new
  end

  def create
    @dane = Dane.new(dane_params)
    if @dane.save
      redirect_to root_path, notice: 'Dane created!'
    else
    flash.now[:alert] = 'All fields are required'
    render :new
    end
  end

  def edit
    @dane = get_dane
  end

  def update
    @dane = get_dane
    if @dane.update(dane_params)
      redirect_to @dane
    end
  end

  def destroy
    @dane = get_dane

    if @dane.destroy
      redirect_to :danes_path
    else
      redirect_to :back
    end
  end

private
  def get_dane
    Dane.find(params.fetch(:id))
  end

  def dane_params
    params.require(:dane).permit(:username, :password, :password_confirmation, :first_name, :last_name, :bio, :email)
  end
end
