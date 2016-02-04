require 'http'
require 'json'
require 'pry'
require "core_extensions/hash"
require "mutant_school_api_model/version"
require 'mutant_school_api_model/mutant'

module MutantSchoolAPIModel
  BASE_URL = 'https://mutant-school.herokuapp.com/api/v1'.freeze
  REQUEST_METHODS = [:get, :post, :put, :patch, :delete]
end
