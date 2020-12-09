require 'rails_helper'

RSpec.describe User do
  describe 'Validation of User' do
    subject { User.create(name: 'John', email: 'john@domain.com', password: 'password') }

    it 'should have many posts' do
      t = User.reflect_on_association(:posts)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many comments' do
      t = User.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many likes' do
      t = User.reflect_on_association(:likes)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many friendships' do
      t = User.reflect_on_association(:friendships)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many friends' do
      t = User.reflect_on_association(:inverted_friendships)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many pending friendships' do
      t = User.reflect_on_association(:pending_friendships)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many pending friends' do
      t = User.reflect_on_association(:pending_friends)
      expect(t.macro).to eq(:has_many)
    end

    it 'confirms the name of the new user' do
      expect(subject.name).to eq('John')
    end

    it 'Ensure the name of the User not to be empty' do
      expect(subject.name).to_not be_empty
    end

    it 'Ensure the password not to be empty' do
      expect(subject.password).to_not be_empty
    end

    it 'Ensure the name length is less than 20' do
      subject.name = 'a' * 21
      expect(subject.valid?).to_not eq(true)
    end

    it 'confirms count of users increase by 1' do
      expect { User.create(name: 'John', email: 'john@me.com', password: 'passor') }.to change { User.count }.by(1)
    end
  end
end
