require 'rails_helper'

RSpec.describe 'プロフィール機能', type: :system do
  let(:user) { create(:user, name: 'taji') }

  before { sign_in user }

  describe 'プロフィールの閲覧と編集' do
    it 'プロフィールを確認して、その情報を編集することができる' do
      visit root_path

      expect(page).to have_selector 'h1', text: '全体タイムライン'

      within '.navbar' do
        expect(page).to have_button 'ログアウト'
        click_on 'taji'
      end

      expect(page).to have_selector 'h1', text: 'プロフィール'
      expect(page).to have_selector 'h2', text: 'taji'
      expect(page).to have_content '自己紹介'
      expect(page).to have_content 'ブログURL'

      click_on 'プロフィール編集'

      expect(page).to have_selector 'h1', text: 'プロフィール編集画面'

      fill_in '名前',	with: 'tajimatakumi'
      fill_in '自己紹介',	with: 'こんにちは！私の名前はたじまです。'
      fill_in 'ブログURL',	with: 'https://example.com'

      click_on '更新する'

      expect(page).to have_content 'プロフィールを編集しました。'
      expect(page).to have_selector 'h1', text: 'プロフィール'
      expect(page).to have_selector 'h2', text: 'tajimatakumi'
      expect(page).to have_content 'こんにちは！私の名前はたじまです。'
      expect(page).to have_content 'https://example.com'
    end
  end
end
