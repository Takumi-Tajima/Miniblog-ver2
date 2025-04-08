require 'rails_helper'

RSpec.describe 'フォロー中のユーザーの投稿', type: :system do
  let(:user) { create(:user) }
  let(:sasaki) { create(:user, name: 'sasaki') }
  let(:tanaka) { create(:user, name: 'tanaka') }

  before do
    sign_in user
    user.follow(sasaki)
    create(:post, user: sasaki, content: 'sasakiの投稿')
    create(:post, user: tanaka, content: 'tanakaの投稿')
  end

  it 'フォロー中のユーザーの投稿のみを表示できること' do
    visit root_path

    expect(page).to have_selector 'h1', text: '全体タイムライン'
    expect(page).to have_content 'sasakiの投稿'
    expect(page).to have_content 'tanakaの投稿'

    click_on 'フォロー中のユーザーの投稿'

    expect(page).to have_selector 'h1', text: 'フォロー中のユーザーの投稿'
    expect(page).to have_content 'sasakiの投稿'
    expect(page).not_to have_content 'tanakaの投稿'
  end
end
