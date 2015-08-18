require "spec_helper"

describe CSVReader do
  describe "valid data input" do
    let(:file_path) { File.dirname(__FILE__) + "/../spec/fixtures/tax.csv" }
    let(:products) { CSVReader.new(file_path)}

    let(:expected_data) do
      [
        {
          quantity: 1,
          product: "HTML/CSS book",
          price: 12.49,
          type: "duty_free"
        },
        {
          quantity: 1,
          product: "music cd",
          price: 14.99,
          type: "basic"
        },
        {
          quantity: 1,
          product: "chocolate bar",
          price: 0.85,
          type: "duty_free"
        },
        {
          quantity: 1,
          product: "imported box of chocolates",
          price: 10.00,
          type: "import"
        },
        {
          quantity: 1,
          product: "imported bottle of perfume",
          price: 47.5,
          type: "basic_import"
        }
      ]
    end

    it "returns an list of taxes classified" do
      expect(products.classify).to eq(expected_data)
    end
  end
end
