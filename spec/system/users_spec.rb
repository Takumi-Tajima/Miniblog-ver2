require 'rails_helper'

RSpec.describe '他ユーザーのプロフィール閲覧', type: :system do
  let(:michael) { create(:user, name: 'othermichael', biography: '私の名前はMichaelです', blog_url: 'https://www.example.com') }

  before do
    create(:post, user: michael, content: '今日もいい天気ですね')
  end

  it '他のユーザーのプロフィールを閲覧することができる' do
    visit root_path

    expect(page).to have_selector 'h1', text: '全体タイムライン'
    expect(page).to have_content '今日もいい天気ですね'

    click_on 'othermichael'

    expect(page).to have_selector 'h1', text: 'othermichaelさんのプロフィール'
    expect(page).to have_content '私の名前はMichaelです'
    expect(page).to have_content 'https://www.example.com'
  end
end
