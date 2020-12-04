require 'rails_helper'

RSpec.describe Friendship do
  describe 'Validation of Like' do
    let(:user) { User.create(name: 'Johny', email: 'johny@domain.com', password: 'password') }

    let(:user2) { User.create(name: 'Johny2', email: 'johny2@domain.com', password: 'password') }

    subject { Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: true) }

    it 'should belong to user' do
      expect { Friendship belong_to(:user) }
    end

    it 'should belong to friend' do
      expect { Friendship belong_to(:friend) }
    end

    it 'confirms count of friendships increase by 1' do
      expect { subject }.to change { Friendship.count }.by(1)
    end
  end
end
