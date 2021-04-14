# frozen_string_literal: true

RSpec.shared_context 'with shared methods', shared_context: :metadata do
  let(:user) { create(:user) }
  let(:home) { create(:home) }
  let(:auth_headers) { user.create_new_auth_token.merge }
end

RSpec.configure do |rspec|
  rspec.include_context 'with shared methods', include_shared: true
end
