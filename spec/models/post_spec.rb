require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#liked_by?' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context 'ユーザーが投稿にいいねをしている場合' do
      before { create(:like, user: user, post: post) }

      it 'trueを返すこと' do
        expect(post.liked_by?(user)).to be true
      end
    end

    context 'ユーザーが投稿にいいねをしていない場合' do
      it 'falseを返すこと' do
        expect(post.liked_by?(user)).to be false
      end
    end
  end
end
