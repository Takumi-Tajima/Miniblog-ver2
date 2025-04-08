require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  let(:user) { create(:user) }
  let(:henry) { create(:user, name: 'henry') }

  before do
    create(:post, user: henry, content: '今日もいい天気ですね')
    sign_in user
  end

  describe 'フォロー機能' do
    it 'フォローできること' do
      visit root_path

      expect(page).to have_selector 'h1', text: '全体タイムライン'
      expect(page).to have_content '今日もいい天気ですね'

      click_on 'henry'

      expect(page).to have_selector 'h1', text: 'henryさんのプロフィール'

      expect do
        click_on 'フォローする'
        expect(page).to have_content 'henryをフォローしました。'
      end.to change(user.following, :count).by(1)

      expect(page).to have_selector 'h1', text: 'henryさんのプロフィール'
      expect(page).to have_button 'フォロー中'
    end
  end

  describe 'フォロー解除機能' do
    before { create(:relationship, follower_id: user.id, followed_id: henry.id) }

    it 'フォロー解除できること' do
      visit root_path

      expect(page).to have_selector 'h1', text: '全体タイムライン'
      expect(page).to have_content '今日もいい天気ですね'

      click_on 'henry'

      expect(page).to have_selector 'h1', text: 'henryさんのプロフィール'

      expect do
        click_on 'フォロー中'
        expect(page).to have_content 'henryのフォローを解除しました。'
      end.to change(user.following, :count).by(-1)

      expect(page).to have_selector 'h1', text: 'henryさんのプロフィール'
      expect(page).to have_button 'フォローする'
    end
  end
end
