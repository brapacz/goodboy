RSpec.describe Goodboy::Commands::Release do
  it { expect(subject).to be_respond_to :run! }
end
