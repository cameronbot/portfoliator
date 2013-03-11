class TransactionsController < ApplicationController
  before_filter :find_portfolio
  before_filter :find_holding
  before_filter :find_transaction, :only => [:show, :edit, :update, :destroy]

  def new
    @transaction = @holding.transactions.build
  end

  def create
    date = params[:transaction][:date]
    unless date.empty?
      params[:transaction][:date] = DateTime.strptime(date, "%m/%d/%Y").utc
    end

    @transaction = @holding.transactions.build(params[:transaction])

    if @transaction.save
      flash[:notice] = "Transaction for #{@holding.ticker} added."

      @holding.total_shares = @holding.transactions.sum(:shares)
      @holding.total_cost = @holding.transactions.sum(:cost)
      @holding.save!

      redirect_to portfolio_path(@portfolio)
    else
      flash[:alert] = "Transaction was not saved."
      render "new"
    end
  end

private
  def find_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end

  def find_holding
    @holding = @portfolio.holdings.find(params[:holding_id])
  end

  def find_transaction
    @transaction = @portfolio.holdings.find(params[:id])
  end
end
