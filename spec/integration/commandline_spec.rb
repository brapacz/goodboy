RSpec.describe "Features" do
  after { FileUtils.remove_entry_secure gem_parent_path }
  before do
    previous_pwd = Dir.pwd
    begin
      expect { `cd "#{gem_parent_path}" && bundle gem "#{gem_name}" && cd "#{gem_name}"` }.to have_exit_status 0
      # puts "setting working directory to #{gem_path.inspect}"
      Dir.chdir gem_path
      puts `pwd`
      expect { `git init && git add . && git commit -m "initial commit"` }.to have_exit_status 0
    ensure
      # puts "restoring working directory to #{previous_pwd.inspect}"
      Dir.chdir previous_pwd
    end
  end

  let(:gem_parent_path) { Dir.mktmpdir }
  let(:gem_path) { File.join(gem_parent_path, gem_name) }
  let(:gem_name) { 'foogem' }

  let(:real_config) { Goodboy::Config.new }

  let(:goodboy_cmd) { 'DEBUG=1 goodboy' }

  it { expect(gem_path).to_not be_empty }

  describe 'initialization' do
    let(:current_change_file_path) { File.join(gem_path, real_config.current_change_file) }

    it { expect { `#{goodboy_cmd} init` }.not_to have_exit_status 0 }

    context 'ran successfully' do
      before { expect { `#{goodboy_cmd} init "#{gem_name}"` }.to have_exit_status 0 }

      it { expect(File.exists?(current_change_file_path)).to be_truthy }
      it { expect { `#{goodboy_cmd} init "#{gem_name}"` }.not_to have_exit_status 0 }

      describe "last change file" do
        subject { YAML.load_file(current_change_file_path) }

        it { is_expected.to match hash_including('version' => 'patch', 'project_name' => gem_name, 'description' => be_a(String)) }
      end

      it { expect { `#{goodboy_cmd} release` }.not_to have_exit_status 0 }

      # it { binding.pry; 1 }

      context 'and all changes are commited' do
        before { expect { `git add #{real_config.current_change_file} && git commit -m "initialized goodboy"` } }

        it { expect { `#{goodboy_cmd} release` }.to have_exit_status 0 }
      end
    end
  end

  describe 'release' do
    it { expect { `#{goodboy_cmd} release` }.not_to have_exit_status 0 }
  end
end
