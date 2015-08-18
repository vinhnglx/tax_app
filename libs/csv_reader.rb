module TaxApp
  class CSVReader
    # Public: Returns the path of csv file
    attr_reader :file

    # Public: Initialize a CSVReader
    #
    # file - Path to data.
    def initialize(file)
      @file = file
    end

    # Public: A set of duty free goods key words
    DUTY_FREE_KEYS = ["book", "paper", "newspaper", "chocolate", "milk",
                     "water", "coffee", "cheese", "cook", "beer",
                     "vegetable", "headache", "toothache", "cold",
                     "cough", "fever", "backache", "diabetes", "allergy",
                     "diarrhea"]

    # Public: A set of import goods key words
    IMPORT_KEYS = ["import"]

    # Public: Listing taxes classified
    #
    # Example
    #   products = CSVReader.new(/path/to/csv)
    #   products.classify
    #   # => [{quantity: 1, product: "HTML/CSS book", price: 12.49, type: "duty free"}]
    #
    # Returns an array taxes classified
    def classify
      _tax_classify(file)
    end

    private

    # Private: Regex match keyword in Array
    #
    # Example
    #
    #   _partial_include?("my_key")
    #   # => true
    #
    # Returns a boolean value
    def _partial_include?(array, key)
      array.each do |e|
        return true if key =~ /#{e}/
      end
      return false
    end

    # Private: Taxes classification.
    # 4 kind of taxes:
    #   duty_free
    #   import        : rate of 5%
    #   basic_import  : rate of 15%
    #   basic         : rate of 10%
    # Example
    #
    #   _tax_classify(file)
    #   # => [{quantity: 1, product: "HTML/CSS book", price: 12.49, type: "duty_free"}]
    #
    # Returns array taxes classified
    def _tax_classify(file)
      products = []
      CSV.foreach(file, headers: true) do |row|
        quantity, name, price = row[0], row[1], row[2]
        obj = {
          quantity: quantity.to_i,
          product: name,
          price: price.to_f
        }
        # Classify
        if _partial_include?(IMPORT_KEYS, name) && _partial_include?(DUTY_FREE_KEYS, name)
          products << obj.merge!(type: "import")
        elsif _partial_include?(DUTY_FREE_KEYS, name)
          products << obj.merge!(type: "duty_free")
        elsif _partial_include?(IMPORT_KEYS, name)
          products << obj.merge!(type: "basic_import")
        else
          products << obj.merge!(type: "basic")
        end
      end
      products
    end
  end
end
