class PortfoliosController < ApplicationController
  before_filter :find_portfolio, :only => [:show, :edit, :update, :destory]

  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(params[:portfolio])
    if @portfolio.save
      flash[:notice] = "Portfolio created."
      redirect_to portfolio_path(@portfolio)
    else
      flash[:alert] = "Portfolio not created."
      render "new"
    end
  end

  def show
    @holdings = @portfolio.holdings.all
  end

private
  def find_portfolio
    @portfolio = Portfolio.find(params[:id])
  end
end
