require 'addressable/uri'
require 'http'
require 'json'

module MutantSchoolAPIModel
  module REST
    class Request
      BASE_URL = 'https://mutant-school.herokuapp.com/api/v1'.freeze
      REQUEST_METHODS = [:get, :post, :put, :patch, :delete]
      attr_accessor :path, :request_method, :uri
      alias verb request_method

      def intialize(request_method, path)
        @uri = Addressable::URI.parse(path.start_with?('http') ? path : BASE_URL + path)
        @path = @url.path
        @request_method = request_method
      end

      def perform

      end
    end
  end
end
