# frozen_string_literal: true

RSpec.describe Kubo do
  it "has a version number" do
    expect(Kubo::VERSION).not_to be nil
  end
end

RSpec.describe Kubo::Zip do
  before do
    @kubo = Kubo::Zip.new
  end

  context "Initialize" do
    it "Zip instance" do
      expect(@kubo.respond_to?("time=")).to eq(true)
      expect(@kubo.respond_to?("path=")).to eq(true)
    end
  end
end

RSpec.describe Kubo::Zip do
  before do
    @times = { seconds: "1s", minutes: "1m", hours: "1h", days: "1d", years: "1y" }
    @kubo  = Kubo::Zip.new(@times[:hours])
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
