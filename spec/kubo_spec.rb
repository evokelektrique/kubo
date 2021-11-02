# frozen_string_literal: true

RSpec.describe Kubo do
  it "has a version number" do
    expect(Kubo::VERSION).not_to be nil
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d" }
    @path  = "./test/my_cache"
    @kubo = Kubo::Zip.new(@times[:hours], @path)
  end

  context "Initialize" do
    it "Zip instance" do
      expect(@kubo.respond_to?("time=")).to eq(true)
      expect(@kubo.respond_to?("path=")).to eq(true)
    end
  end

  context "Errors" do
    it "Raise an error for invalid expiration" do
      @kubo.time = "0h"
      expect { @kubo.parse_time(@kubo.time) }.to raise_error(StandardError)
    end

    it "Raise an error when file is not found" do
      key = "forbbiden_file"
      expect(@kubo.file_exists?(key)).to eq(false)
    end
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d" }
    @path  = "./test/my_cache"
    @kubo  = Kubo::Zip.new(@times[:hours], @path)
  end

  context "Convert" do
    it "To seconds" do
      expect(@kubo.parse_time(@times[:seconds])).to eq(1)
    end

    it "To minutes" do
      expect(@kubo.parse_time(@times[:minutes])).to eq(60)
    end

    it "To hours" do
      expect(@kubo.parse_time(@times[:hours])).to eq(3600)
    end

    it "To days" do
      expect(@kubo.parse_time(@times[:days])).to eq(864_00)
    end
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d" }
    @path  = "./test/my_cache"
    @kubo  = Kubo::Zip.new(@times[:hours], @path)
  end

  it "Generate a path" do
    directory_status = Dir.exist?(@kubo.path)
    expect(directory_status).to eq(true)
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d" }
    @path  = "./test/my_cache"
    @kubo  = Kubo::Zip.new(@times[:hours], @path)
    @key   = "test_key"
    @value = "Test value!"
  end

  it "Save compressed content to the file" do
    @kubo.save(@key, @value)
    file = @kubo.file_empty?(@key)
    expect(file).to be > 0
  end

  it "Decompress gzip" do
    value = @kubo.read(@key)
    expect(value.size).to be > 0
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d" }
    @path  = "./test/my_cache"
    @kubo  = Kubo::Zip.new(@times[:seconds], @path)
    @key   = "test_key"
  end

  it "Validate file expiration" do
    # Sleep for a second so it expires
    sleep 1
    expired = @kubo.expired?(@key)
    expect(expired).to be(true)
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d" }
    @path  = "./test/my_cache"
    @kubo  = Kubo::Zip.new(@times[:seconds], @path)
    @key   = "test_key"
    @value = "Test value!"
  end

  it "Flush a file" do
    @kubo.flush(@key)
    path = @kubo.get_file_path(@key)
    expect(File.size(path)).to be(0)
  end

  it "Delete a file" do
    @kubo.delete(@key)
    expect(@kubo.file_exists?(@key)).to eq(false)
  end

  it "Delete the file if it is expired" do
    @kubo.save(@key, @value)
    # Sleep for a second so it expires
    sleep 1
    @kubo.delete_if_expired(@key)
    expect(@kubo.file_exists?(@key)).to eq(false)
  end
end
