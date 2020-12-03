require 'rails_helper'

RSpec.describe Comment do
  describe 'Validation of Like' do
    let(:user) { User.create(name: 'Johny', email: 'johny@domain.com', password: 'password') }

    let(:post) { Post.create(content: 'Test', user_id: user.id) }

    subject { Comment.create(user_id: user.id, post_id: post.id, content: 'Hello, testing the comment model') }

    let(:Comment) { Comment.create(user_id: user.id, post_id: post.id) }

    it 'should belong to user' do
      expect { Comment belong_to(:user) }
    end

    it 'should belong to post' do
      expect { Comment belong_to(:post) }
    end

    it 'Ensure the content is present' do
      subject.content = ''

      expect(subject.valid?).to_not eq(true)
    end

    it 'confirms count of Comments increase by 1' do
      expect { subject }.to change { Comment.count }.by(1)
    end

    it 'Ensure the content length is less than 200' do
      subject.content = 'a' * 201

      expect(subject.valid?).to_not eq(true)
    end
  end
end
