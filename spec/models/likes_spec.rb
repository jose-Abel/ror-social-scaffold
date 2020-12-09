require 'rails_helper'

RSpec.describe Like do
  describe 'Validation of Like' do
    let(:user) { User.create(name: 'Johny', email: 'johny@domain.com', password: 'password') }

    let(:post) { Post.create(content: 'Test', user_id: user.id) }

    subject { Like.create(user_id: user.id, post_id: post.id) }

    let(:like) { Like.create(user_id: user.id, post_id: post.id) }

    it 'should belong to user' do
      expect { Like belong_to(:user) }
    end

    it 'should belong to post' do
      expect { Like belong_to(:post) }
    end

    it 'confirms count of likes increase by 1' do
      expect { subject }.to change { Like.count }.by(1)
    end

    it 'confirms uniqueness of user id' do
      subject
      expect(like.valid?).to_not eq(true)
    end
  end
end
