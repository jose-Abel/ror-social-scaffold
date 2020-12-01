require 'rails_helper'

RSpec.describe Post do
  describe 'Validation of Post' do
    subject { Post.new(content: 'Test', user_id: 1)}

    it 'confirms count of posts increase by 1' do
      expect { subject.save() }.to change { Post.count }.by(1)
    end
  end
end
