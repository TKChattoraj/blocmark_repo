require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  # Shoulda tests for user_name
  it {should validate_length_of(:user_name).is_at_least(5)}

  # Shoulda tests for email
  it {should validate_uniqueness_of(:email)}
  it {should validate_length_of(:email).is_at_least(3)}
  it {should allow_value("user@chattoraj.com").for(:email)}
  it {should_not allow_value("userchattoraj.com").for(:email)}

  #Shoulda tests for password
  it {should have_secure_password}
  it {should validate_length_of(:password).is_at_least(6)}

  describe "attributes" do
    it "should respond to user_name" do
      expect(user).to respond_to(:user_name)
    end
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
  end
end
