# frozen_string_literal: true

# RSpec.describe Kubo do
#   it "has a version number" do
#     expect(Kubo::VERSION).not_to be nil
#   end
# end

RSpec.describe Kubo::Cache do
  before do
    @type_zip = :zip
    @type_marshal = :marshal
  end

  context "initialize" do
    it "creates a zip instance" do
      kubo = Kubo::Cache.new(@type_zip)
      expect(kubo.type).to eq(@type_zip)
    end

    it "creates a marshal instance" do
      kubo = Kubo::Cache.new(@type_marshal)
      expect(kubo.type).to eq(@type_marshal)
    end
  end
end
