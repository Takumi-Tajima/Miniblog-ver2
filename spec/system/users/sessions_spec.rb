require 'rails_helper'

RSpec.describe 'ユーザーのログイン機能', type: :system do
  context 'ログインしてない時' do
    before do
      create(:user, name: 'tajitaku', password: 'password123')
    end

    it 'ログインができること' do
      visit new_user_session_path

      expect(page).to have_selector 'h1', text: 'ログイン'

      fill_in '名前', with: 'tajitaku'
      fill_in 'パスワード', with: 'password123'
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました。'

      within '.navbar' do
        expect(page).to have_content 'tajitaku'
        expect(page).to have_button 'ログアウト'
      end
    end
  end

  context 'ログインしている時' do
    let(:user) { create(:user, name: 'maeda') }

    before { sign_in user }

    it 'ログアウトできること' do
      visit root_path

      expect(page).to have_selector 'h1', text: '全体タイムライン'

      within '.navbar' do
        expect(page).to have_content 'maeda'
        expect(page).to have_button 'ログアウト'
      end

      within '.navbar' do
        click_on 'ログアウト'
      end

      expect(page).to have_content 'ログアウトしました。'
    end

    it 'ログイン画面にアクセスできないこと' do
      visit new_user_session_path

      expect(page).to have_content 'すでにログインしています。'
      expect(page).to have_content '全体タイムライン'
    end
  end
end
