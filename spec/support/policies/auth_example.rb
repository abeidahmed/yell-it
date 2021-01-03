RSpec.shared_examples "being_a_visitor" do
  context "when being a visitor" do
    let(:user) { nil }

    it "raises an error" do
      expect { subject }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
