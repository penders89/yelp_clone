require 'spec_helper'

describe User do
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_many(:reviews).order('created_at desc') }
  it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20) }
  
  let(:user) { User.new(username: "Test Name", email: "test@example.com", password: "password") }
  
  it "should save emails as lower case" do 
    mixed_case_email = "TeSt@ExAmple.com"
    user.email = mixed_case_email
    user.save
    expect(user.email).to eq(mixed_case_email.downcase)
  end
  
  it "should not allow two users with the same email, case-insensitive" do 
    user.save
    second_user = User.new(username: "Test Name", email: "TEST@example.com", password: "password")
    expect(second_user.save).to eq(false)
  end
  
  
  
end