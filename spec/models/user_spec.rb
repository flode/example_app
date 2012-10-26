# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Flo", email: "flo@f.de", password: "foobar", password_confirmation: "foobar")
  end

  subject {@user}
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it {should be_valid}

  describe "si il n'y a pas de nom" do
    before {@user.name = ""}
    it { should_not be_valid }
  end
  describe "when name is too long" do
    before {@user.name = "f" * 51}
    it { should_not be_valid }
  end
  describe "email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_adress|
        @user.email = invalid_adress
        @user.should_not be_valid
      end
    end
    it "should be valid" do
      addresses = %w[flo.de@hotmail.de user@foo.COM frst.lst@foo.jp]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
       end
     end
  end
  describe "password not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end
  describe "password confirmation does not match" do
    before {@user.password_confirmation = "other"}
    it { should_not be_valid }
  end
  describe "password_confirmation is nil" do
    before { @user.password_confirmation = nil }
    it {should_not be_valid }
  end

  describe "authenticate works" do
    before { @user.save }
    let ( :found_user ) {User.find_by_email(@user.email) }

    describe "with valid password" do
      it {should == found_user.authenticate(@user.password) }
    end
    describe "with invalid password" do
      let(:user_for_invalid_password) { @user.authenticate("invalid") }
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
