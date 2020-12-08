require 'rails_helper'

RSpec.describe FriendshipHelper do
  describe 'friendship_check method' do
    let(:user) { User.create(name: 'Johny', email: 'johny@domain.com', password: 'password') }

    let(:user2) { User.create(name: 'Johny2', email: 'johny2@domain.com', password: 'password') }

    it 'should return send invite string when no one has sent a friend request' do
      expect(friendship_check(user, user2)).to eq('send_invite')
    end

    it 'should confirm user sent a friend request to user2 and return pending string' do
      Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: false)

      expect(friendship_check(user, user2)).to eq('pending')
    end

    it 'should confirm user2 received the friend request from user and return Accept_reject string' do
      Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: false)

      expect(friendship_check(user2, user)[0]).to eq('Accept_reject')
    end

    it 'should confirm user2 received the friend request from user and return friendship' do
      fs = Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: false)

      expect(friendship_check(user2, user)[1]).to eq(fs)
    end

    it 'should confirm user and user2 are friends' do
      fs = Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: false)

      fs.update_attributes(confirmed: true)

      friendship2 = Friendship.new(user_id: fs.friend_id, friend_id: fs.user_id, confirmed: true)

      friendship2.save

      expect(friendship_check(user2, user)).to eq('friends')
    end
  end
end
