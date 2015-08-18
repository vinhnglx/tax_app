require "csv"
require_relative "libs/csv_reader"
require_relative "libs/product"

module TaxApp
  def self.calc(file)
    data_path = File.dirname(__FILE__) + file

    products = TaxApp::CSVReader.new(data_path)
    products_classified = products.classify
    taxes = TaxApp::Product.calc(products_classified)
    output = TaxApp::Product.export(taxes)
  end
end

TaxApp.calc("/data/tax.csv")
