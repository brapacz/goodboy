RSpec.describe "Features" do
  # let(:gem_dir) { @gem_dir }
  around do |example|
    with_example_gem! do |path|
      @gem_path = File.join(path, gem_name)
      begin
        example.run
      ensure
        @gem_path = nil
      end
    end
  end

  let(:gem_path) { @gem_path }
  let(:gem_name) { 'foogem' }

  let(:real_config) { Goodboy::Config.new }

  it { expect(gem_path).to_not be_empty }

  describe 'initialization' do
    let(:current_change_file_path) { File.join(gem_path, real_config.current_change_file) }

    it { expect { `cd "#{gem_path}" && goodboy init`  }.not_to have_exit_status 0 }

    context 'ran successfully' do
      before { expect { `cd "#{gem_path}" && goodboy init "#{gem_name}"` }.to have_exit_status 0 }

      it { expect(File.exists?(current_change_file_path)).to be_truthy }
      it { expect { `cd "#{gem_path}" && goodboy init "#{gem_name}"`  }.not_to have_exit_status 0 }

      describe "last change file" do
        subject { YAML.load_file(current_change_file_path) }

        it { is_expected.to match hash_including('version' => 'patch', 'project_name' => gem_name, 'description' => be_a(String)) }
      end
    end
  end

  describe 'release' do
    it { expect { `cd "#{gem_path}" && goodboy release`  }.not_to have_exit_status 0 }
    it { expect { `cd "#{gem_path}" && goodboy release`  }.not_to have_exit_status 0 }
  end

  private

  def with_example_gem!
    Dir.mktmpdir do |path|
      expect { `cd "#{path}" && bundle gem "#{gem_name}"` }.to have_exit_status 0
      yield(path)
    end
  end
end
