require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "Lak@1993", password_confirmation: "Lak@1993")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = '' }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = '' }
  	it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: "", password_confirmation: "")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before do
      @user.password_confirmation = "Lak@199"
    end
    it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email is too long" do
  	before { @user.email = "a" * 255 + "@example.com" }
  	it { should_not be_valid}
  end

  describe "when email format is not valid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |address|
        	@user.email = address
        	expect(@user).not_to be_valid
        end
    end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |address|
  			@user.email = address
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      @user.password = @user.password_confirmation = "a" * 5
    end
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before do
      @user.save
    end
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

end