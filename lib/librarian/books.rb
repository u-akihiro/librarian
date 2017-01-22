module Librarian
  class Books
    #
    def query
    end
  end

  class Query
  end

  class CommonTermQuery
    extend Forwardable

    def_delegators :@terms, :[], :<<

    def initialize
      @terms = []
    end
  end

  class SpecificTermQuery
    extend Forwardable

    def_delegators :@terms, :[]

    def initialize
      keys = %i(intitle inauthor inpublisher subject isbn lccn oclc)

      @terms = keys.inject({}) do |memo, item|
        memo[item] = []
        memo
      end
    end

    def to_str
      terms = @terms.map { |key, array| [ key, array.join('+') ] }.to_h
      terms = terms.inject(array = []) do |str, (key, value)|
          array << "#{key}:#{value}" unless value.empty?
          array
      end

      terms.join('+')
    end
  end
end
