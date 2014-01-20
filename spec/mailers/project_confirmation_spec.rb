require "spec_helper"

describe ProjectConfirmation do
  describe "receipt" do
    let(:mail) { ProjectConfirmation.receipt }

    it "renders the headers" do
      mail.subject.should eq("A New Project Has Been Created!")
      mail.to.should eq(["user@example.com"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
