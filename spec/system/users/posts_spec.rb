require 'rails_helper'

RSpec.describe 'ポストの投稿', type: :system do
  let(:user) { create(:user) }

  describe 'ポストの新規投稿機能' do
    context 'ログインしている時' do
      before { sign_in user }

      it 'ポストの新規投稿ができること' do
        visit root_path

        expect(page).to have_selector 'h1', text: '全体タイムライン'

        click_on '新規投稿'

        expect(page).to have_selector 'h1', text: 'ポスト新規投稿'

        fill_in '内容',	with: 'ここにテキストが入ります。'

        expect do
          click_on '登録する'
          expect(page).to have_content 'ポストを登録しました。'
        end.to change(user.posts, :count).by(1)

        expect(page).to have_content 'ここにテキストが入ります。'
        expect(page).not_to have_selector 'h1', text: '全体タイムライン'
      end
    end

    context 'ログインしてない時' do
      it '新規投稿ボタンが表示されていないこと' do
        visit root_path

        expect(page).to have_selector 'h1', text: '全体タイムライン'
        expect(page).not_to have_link '新規投稿'
      end
    end
  end

  describe 'ポストの編集機能' do
    let(:post) { create(:post, user: user, content: 'ポストの投稿内容') }

    before { sign_in user }

    it 'ポストの編集ができること' do
      visit post_path(post)

      expect(page).to have_current_path post_path(post)
      expect(page).to have_content 'ポストの投稿内容'

      click_on '編集'

      expect(page).to have_selector 'h1', text: 'ポストの編集'

      fill_in '内容',	with: 'ここにテキストが入ります。'

      expect do
        click_on '更新する'
        expect(page).to have_content 'ポストを編集しました。'
      end.not_to change(user.posts, :count)

      expect(page).to have_content 'ここにテキストが入ります。'
    end
  end

  describe 'ポストの削除機能' do
    let(:post) { create(:post, user: user, content: 'ポストの投稿内容') }

    before { sign_in user }

    it 'ポストの削除ができること' do
      visit post_path(post)

      expect(page).to have_current_path post_path(post)
      expect(page).to have_content 'ポストの投稿内容'

      expect do
        accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content 'ポストを削除しました。'
      end.to change(user.posts, :count).by(-1)

      expect(page).to have_selector 'h1', text: '全体タイムライン'
      expect(page).not_to have_content 'ポストの投稿内容'
    end
  end
end
