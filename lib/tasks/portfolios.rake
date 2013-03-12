namespace :portfolio do
  desc "Update porfolios"
  task :update, [:id] => [:environment] do |t, args|
    require 'csv'
    require 'open-uri'

    @portfolio = Portfolio.find(args.id)
    @holdings = @portfolio.holdings.all

    #http://finance.yahoo.com/d/quotes.csv?s=DOW+MSFT+AAPL+GOOG&f=sl1
    tickers = @holdings.map { |holding| holding.ticker }.join("+")
    daily_data = CSV.parse(open("http://finance.yahoo.com/d/quotes.csv?s=" + tickers + "&f=sl1"))

    daily_data.each do |data|
      holding = @holdings.shift
      holding[:total_value] = (holding[:total_shares] * data[1].to_f).round(2)
      holding.save!
      puts "Updating #{holding.ticker}"
    end

    @portfolio.price_updated = Time.new.to_i
    @portfolio.save!

    puts "Prices have been updated."
  end
end
