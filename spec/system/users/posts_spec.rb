require 'rails_helper'

RSpec.describe 'ポストの投稿', type: :system do
  describe 'ポストの新規投稿機能' do
    context 'ログインしている時' do
      let(:user) { create(:user) }

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

        expect(page).to have_selector 'h1', text: '全体タイムライン'
        expect(page).to have_content 'ここにテキストが入ります。'
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
end
