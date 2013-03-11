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
    @portfolio.price_updated = Time.at(@portfolio.price_updated).strftime "%Y-%m-%d %H:%M:%S"
  end

  def update_prices
    require 'csv'
    require 'open-uri'

    @portfolio = Portfolio.find(params[:portfolio_id])
    @holdings = @portfolio.holdings.all

    #http://finance.yahoo.com/d/quotes.csv?s=DOW+MSFT+AAPL+GOOG&f=sl1
    tickers = @holdings.map { |holding| holding.ticker }.join("+")
    daily_data = CSV.parse(open("http://finance.yahoo.com/d/quotes.csv?s=" + tickers + "&f=sl1"))

    daily_data.each do |data|
      holding = @holdings.shift
      holding[:total_value] = (holding[:total_shares] * data[1].to_f).round(2)
      holding.save!
    end

    @portfolio.price_updated = Time.new.to_i
    @portfolio.save!

    flash[:notice] = "Prices have been updated."
    redirect_to portfolio_path(@portfolio)
  end

private
  def find_portfolio
    @portfolio = Portfolio.find(params[:id])
  end
end
