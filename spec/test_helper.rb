$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mutant_school_api_model'

require 'minitest/autorun'

require "minitest/reporters"
Minitest::Reporters.use!

require 'factories/mutant_factory'
require "mocha/mini_test"

def with_fake_http(&block)
  HTTP.stubs(:post).returns(stub(
    code: 201,
    to_s: "{\"id\":600,\"mutant_name\":\"Wolverine\",\"power\":\"Healing\",\"real_name\":\"James \\\"Logan\\\" Howlett\",\"created_at\":\"2016-02-08T02:42:05.565Z\",\"updated_at\":\"2016-02-08T02:42:05.565Z\",\"eligibility_begins_at\":\"1974-10-01T00:00:00.000Z\",\"eligibility_ends_at\":null,\"may_advise_beginning_at\":\"1974-10-01T00:00:00.000Z\",\"url\":\"https://mutant-school.herokuapp.com/api/v1/mutants/600\"}"
  ))

  HTTP.stubs(:get).returns(stub(
    code: 200,
    to_s: "{\"id\":600,\"mutant_name\":\"Wolverine\",\"power\":\"Healing\",\"real_name\":\"James \\\"Logan\\\" Howlett\",\"created_at\":\"2016-02-08T02:42:05.565Z\",\"updated_at\":\"2016-02-08T02:42:05.565Z\",\"eligibility_begins_at\":\"1974-10-01T00:00:00.000Z\",\"eligibility_ends_at\":null,\"may_advise_beginning_at\":\"1974-10-01T00:00:00.000Z\",\"url\":\"https://mutant-school.herokuapp.com/api/v1/mutants/600\"}",
    is_a?: true
  ))
end
