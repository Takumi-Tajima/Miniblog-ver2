require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, name: 'take') }
  let(:post) { create(:post, content: '最高の人生の過ごしかたを募集するぜお前ら') }

  before { sign_in user }

  describe 'コメントの表示機能' do
    before { create(:comment, post: post, user: other_user, content: 'サウナ一択やろ') }

    it 'コメントが表示されること' do
      visit post_path(post)

      expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'
      expect(page).to have_content 'サウナ一択やろ'
      expect(page).to have_content 'take'
    end
  end

  describe 'コメントの投稿機能' do
    it 'コメントの投稿と表示ができること' do
      visit post_path(post)

      expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'

      fill_in 'コメント',	with: 'サウナ体に悪いらしいよ'

      expect do
        click_on '登録する'
        expect(page).to have_content 'コメントを登録しました。'
      end.to change(post.comments, :count).by(1)

      expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'
      expect(page).to have_content 'サウナ体に悪いらしいよ'
    end

    context 'ログインしてない時' do
      before { sign_out user }

      it 'コメントの投稿ができないこと' do
        visit post_path(post)

        expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'
        expect(page).not_to have_field 'コメント'
        expect(page).not_to have_content '登録する'
      end
    end
  end

  describe 'コメントの削除機能' do
    context '自分のコメントの場合' do
      before { create(:comment, post: post, user: user, content: '水風呂最高だよね') }

      it 'コメントの削除ができること' do
        visit post_path(post)

        expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'
        expect(page).to have_content '水風呂最高だよね'

        expect do
          find('.bi-x-circle').click
          expect(page).to have_content 'コメントを削除しました。'
        end.to change(post.comments, :count).by(-1)

        expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'
        expect(page).not_to have_content '水風呂最高だよね'
      end
    end

    context '他人のコメントの場合' do
      before { create(:comment, post: post, content: '水風呂ありえん') }

      it 'コメントの削除ができないこと' do
        visit post_path(post)

        expect(page).to have_content '最高の人生の過ごしかたを募集するぜお前ら'
        expect(page).to have_content '水風呂ありえん'

        card = find('.card', text: '水風呂ありえん')

        within card do
          expect(page).not_to have_selector '.bi-x-circle'
        end
      end
    end
  end
end
