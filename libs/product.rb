module TaxApp
  class Product
    # Public: Constant variable tax rate for basic_import
    BASIC_IMPORT = 15

    # Public: Constant variable tax rate for import
    IMPORT = 5

    # Public: Constant variable tax rate for basic
    BASIC = 10

    # Public: Calculate the tax for products
    #
    # Example:
    #   products_classified = CSVReader.new(/path/to/csv/file).classify
    #   products_classified.calc
    #   # => [{quantity: 1, product: "HTML/CSS book", price: 12.49}]
    #
    # Returns a tax for products
    def self.calc(products)
      total = []
      products.each do |obj|
        product_type = obj.delete(:type)
        case product_type
        when "import"
          tax = _tax_formular(obj[:price], IMPORT, obj[:quantity])
        when "basic_import"
          tax = _tax_formular(obj[:price], BASIC_IMPORT, obj[:quantity])
        when "basic"
          tax = _tax_formular(obj[:price], BASIC, obj[:quantity])
        else
          tax = 0
        end
        obj[:price] = (obj[:price] + tax).round(2)
        obj[:tax] = tax
        total << obj
      end
      total
    end

    # Public: Export the tax to CSV file
    #
    # Example:
    #   products_classified = CSVReader.new(/path/to/csv/file).classify
    #   taxes = products_classified.calc
    #   products_classified.export(taxes)

    def self.export(total)
      file = File.open('output/output.txt', 'w')
      total.each do |t|
        file.write("#{t[:quantity]}, #{t[:product]}, #{t[:price]}\n")
      end
      taxes = total.map{|x| x[:tax]}
      prices = total.map{|x| x[:price]}
      file.write("\n")
      file.write("Sales Taxes: #{_total(taxes)}\n")
      file.write("Sales Taxes: #{_total(prices)}\n")
    end

    private

    # Private: Tax calculation formular
    #
    # Returns tax
    def self._tax_formular(price, kind, quantity)
      (price * kind / 100) * quantity
    end

    # Private: Total taxes
    #
    # Return total of taxes
    def self._total(taxes)
      taxes.inject(:+).round(2)
    end
  end
end
