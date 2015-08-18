require "spec_helper"

describe Product do
  describe "shows an output receipt details" do
    let(:file_path) { File.dirname(__FILE__) + "/../spec/fixtures/tax.csv" }
    let(:products) { CSVReader.new(file_path)}
    let(:expected_data) do
      [
        {
          quantity: 1,
          product: "HTML/CSS book",
          price: 12.49,
          tax: 0
        },
        {
          quantity: 1,
          product: "music cd",
          price: 16.49,
          tax: 1.499
        },
        {
          quantity: 1,
          product: "chocolate bar",
          price: 0.85,
          tax: 0
        },
        {
          quantity: 1,
          product: "imported box of chocolates",
          price: 10.50,
          tax: 0.5
        },
        {
          quantity: 1,
          product: "imported bottle of perfume",
          price: 54.63,
          tax: 7.125
        }
      ]
    end

    before do
      @products_classified = products.classify
    end

    it "returns a taxes for items" do
       expect(Product.calc(@products_classified)).to eq(expected_data)
    end
  end
end
