require 'rails_helper'

RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザーの新規登録' do
    it 'ユーザーの新規登録ができ、そのアカウントでログインできること' do
      visit new_user_registration_path

      expect(page).to have_content '新規登録'

      fill_in '名前', with: 'tanaka'
      fill_in 'メールアドレス', with: 'tanaka@exmaple.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'

      expect do
        click_button '登録する'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end.to change(User, :count).by(1)

      email = open_last_email

      expect(email.subject).to eq 'メールアドレス確認メール'

      click_first_link_in_email(email)

      expect(page).to have_content 'メールアドレスが確認できました。'
      expect(page).to have_selector 'h1', text: 'ログイン'

      fill_in '名前', with: 'tanaka'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました。'

      within '.navbar' do
        expect(page).to have_content 'tanaka'
        expect(page).to have_button 'ログアウト'
      end
    end
  end

  # TODO: 編集時にコメントアウトの解除を行う
  # describe 'ユーザー情報編集画面へのリンクと、ユーザー情報の編集機能' do
  #   let(:user) { create(:user, name: 'yoshida', email: 'yoshida@exmaple.com', password: 'password') }

  #   before { sign_in user }

  #   it 'ヘッダーにある名前のリンクを押すと、ユーザーの編集画面に遷移すること' do
  #     visit root_path

  #     within '.navbar' do
  #       click_link 'yoshida'
  #     end

  #     expect(page).to have_selector 'h1', text: 'ユーザー情報の編集'
  #     expect(page).to have_field '名前', with: 'yoshida'
  #   end

  #   it 'ユーザーの情報を編集できること' do
  #     visit edit_user_registration_path

  #     expect(page).to have_selector 'h1', text: 'ユーザー情報の編集'
  #     expect(page).to have_field '名前', with: 'yoshida'
  #     expect(page).to have_field 'メールアドレス', with: 'yoshida@exmaple.com'

  #     fill_in '名前',	with: 'takahashi'
  #     fill_in 'メールアドレス',	with: 'takahashi@exmaple.com'
  #     fill_in '現在のパスワード',	with: 'password'

  #     expect do
  #       click_button '更新する'
  #       expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'
  #     end.not_to change(User, :count)

  #     email = open_last_email

  #     expect(email.subject).to eq 'メールアドレス確認メール'

  #     click_first_link_in_email(email)

  #     expect(page).to have_content 'メールアドレスが確認できました。'

  #     visit edit_user_registration_path

  #     expect(page).to have_field '名前', with: 'takahashi'
  #     expect(page).to have_field 'メールアドレス', with: 'takahashi@exmaple.com'
  #   end
  # end
end
