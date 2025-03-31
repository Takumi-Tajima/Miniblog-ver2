require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:henry) { create(:user, name: 'henry') }

  describe '#follow()' do
    it '他のユーザーをフォローできること' do
      user.following.include?(henry).should be_falsey

      expect do
        user.follow(henry)
      end.to change(user.following, :count).by(1)

      user.following.include?(henry).should be_truthy
    end

    it '自分をフォローできないこと' do
      user.following.include?(user).should be_falsey

      expect do
        user.follow(user)
      end.not_to change(user.following, :count)

      user.following.include?(user).should be_falsey
    end

    it 'すでにフォローしているユーザーをフォローできないこと' do
      user.follow(henry)

      user.following.include?(henry).should be_truthy

      expect do
        user.follow(henry)
      end.not_to change(user.following, :count)
    end
  end

  describe '#unfollow()' do
    it 'フォロー解除できること' do
      user.follow(henry)
      user.following.include?(henry).should be_truthy

      expect do
        user.unfollow(henry)
      end.to change(user.following, :count).by(-1)

      user.following.include?(henry).should be_falsey
    end
  end

  describe '#following?' do
    let(:mike) { create(:user, name: 'mike') }

    before { user.follow(henry) }

    it 'フォローしているユーザーとフォローしていないユーザーを真偽値で判定できる' do
      user.following?(henry).should be_truthy
      user.following?(mike).should be_falsey
    end
  end
end
