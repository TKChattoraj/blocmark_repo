require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  # Shoulda tests for user_name
  it {should validate_presence_of(:user_name)}

  # Shoulda tests for email
  # uniqueness, form and length tested under Devise
  #it {should validate_length_of(:email).is_at_least(3)}
  it {should allow_value("user@chattoraj.com").for(:email)}
  it {should_not allow_value("user@@chattoraj.com").for(:email)}
  it {should_not allow_value("userchattoraj.com").for(:email)}

  #Shoulda tests for password
  #it {should have_secure_password}
  # I am not testing the secure password as Devise does this as a feature of the authenticaiton.  But is that ok?  Either the password is encrypted or not and that seems to be entirely a function accomplished within devise and so do I need to test it?
  it {should validate_length_of(:password).is_at_least(8)}
  it {should validate_length_of(:password).is_at_most(72)}

  describe "attributes" do
    it "should respond to user_name" do
      expect(user).to respond_to(:user_name)
    end
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
  end
end
