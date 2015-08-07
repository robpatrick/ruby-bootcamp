require 'rake'
require 'pathname'
require 'tmpdir'

shared_context :rake do
  subject do
    app = Rake::Application.new.tap do |app|
      app.add_import("#{__dir__}/../tasks/#{self.class.top_level_description}")
      allow(Rake).to receive(:application).and_return(app)
      app.load_imports
    end
    app[self.class.description]
  end
end

FILE_NAMES = %w( file1.txt file2.txt pic1.jpg pic2.jpg)

describe 'files.rake' do
  include_context :rake

  before(:each) do
    @test_dir = Pathname.new(Dir.mktmpdir)
    FILE_NAMES.each do |filename|
      File.open( @test_dir.join(filename), 'w' ).close
    end
  end

  describe 'files:list' do
    it 'just works' do
      subject.invoke
    end

    it 'expect list with no params to list the root directory' do
      expect(STDOUT).to receive(:puts).with("readme.md\n")
      subject.invoke
    end

    it 'expect list with a passed in directory to list all files' do
      expect(STDOUT).to receive(:puts).with("file1.txt\nfile2.txt\npic1.jpg\npic2.jpg\n")
      subject.invoke(@test_dir.to_s)
    end

    it 'expect list to filer the results by extension' do
      expect(STDOUT).to receive(:puts).with("file1.txt\nfile2.txt\n")
      subject.invoke(@test_dir.to_s, '*.txt')
    end

    it 'expect list to filer the results by name' do
      expect(STDOUT).to receive(:puts).with("file1.txt\npic1.jpg\n")
      subject.invoke(@test_dir.to_s, '*1.*')
    end

    after(:each) do
      FILE_NAMES.each do |filename|
        File.delete( @test_dir.join(filename) )
      end
      Dir.rmdir(@test_dir)
    end
  end
end