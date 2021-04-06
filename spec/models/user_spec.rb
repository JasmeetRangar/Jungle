require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(
    first_name: 'Michael',
    last_name: 'Scott',
    email: 'mscott@test.com',
    password: '123456',
    password_confirmation: '123456'
  )}

  describe 'Validations' do

    context "All fields are valid" do
      it "creates a new user" do
        expect{user.save}.to change{User.count}.by(1)
      end
    end

    context "Missing fields" do
      it "returns error if passworld is nil" do
        user.password = nil
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to eq ["can't be blank"]
      end

      it "returns error if email is nil" do
        user.email = nil
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:email]).to eq ["can't be blank"]
      end

      it "returns error if first name is nil" do
        user.first_name = nil
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:first_name]).to eq ["can't be blank"]
      end

      it "returns error if last name is nil" do
        user.last_name = nil
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:last_name]).to eq ["can't be blank"]
      end
    end

    context "Invalid fields" do
      it "returns if password and password confirmation do not match" do
        user.password_confirmation = '654321'
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:password_confirmation]).to eq ["doesn't match Password"]
      end

      it "returns error if password is under 6 characters" do
        user.password = '123'
        user.password_confirmation = '123'
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to eq ["is too short (minimum is 6 characters)"]
      end

      it "returns error if email is not unique (not case sensitive)" do
        user.save
        other_user = User.create(first_name: 'Michael', last_name: 'Scott', email: 'MSCOTT@test.com', password: '123456', password_confirmation: '123456')
        expect(other_user).to_not be_valid
        expect(other_user.errors.messages[:email]).to eq ["has already been taken"]
      end
    end

  end

  describe '.authenticate_with_credentials' do

    context "Valid credentials" do
      it "returns the user given a valid email and password" do
        user.save
        expect(User.authenticate_with_credentials('mscott@test.com', '123456')).to eq user
      end

      it "returns the user given an email in the wrong case" do
        user.save
        expect(User.authenticate_with_credentials('MSCOTT@test.com', '123456')).to eq user
      end

      it "returns the user given an email with filler spaces" do
          user.save
          expect(User.authenticate_with_credentials('  mscott@test.com ', '123456')).to eq user
      end
    end


    context "Invalid credentials" do
      it "returns nil given an invalid email" do
        user.save
        expect(User.authenticate_with_credentials('m@test.com', '123456')).to eq nil
      end

      it "returns nil given an invalid password" do
        user.save
        expect(User.authenticate_with_credentials('mscott@test.com', '111111')).to eq nil
      end

    end

  end

end
