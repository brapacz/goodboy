RSpec.describe Goodboy::Commands::Bump do
  it { expect(described_class).to have_attributes command_name: 'bump' }
  it { expect(subject).to be_respond_to :run! }
end
