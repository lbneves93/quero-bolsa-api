# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def authenticated_header(user)
  secret_key = ENV['JWT_SECRET'].to_s
  token = JWT.encode({ user_id: user.id }, secret_key)
  { 'Authorization': "Bearer #{token}" }
end
