RSpec::Matchers.define :have_json_key do |expected_key|
  match do |response|
    @body = MultiJson.load(response.body)

    result = @body.key?(expected_key.to_s)
    result &&= @body[expected_key.to_s] == @expected_val if @val_provided
    result
  end

  chain :with_value do |val|
    @val_provided = true
    @expected_val = val
  end

  description do
    result = "have json key #{expected_key.inspect}"
    result << " with value #{@expected_val.inspect}" if @val_provided
    result
  end

  failure_message_for_should do |actual|
    "expected response " + description + ", was #{@body[expected_key.to_s].inspect}"
  end
end