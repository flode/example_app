# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Flo", email: "flo@f.de")
  end

  subject {@user}
  it { should respond_to(:name)}
  it {should respond_to(:email)}

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
end
