require 'rails_helper'

RSpec.describe 'ポストの閲覧', type: :system do
  let(:user) { create(:user, name: 'taji') }
  let!(:post) { create(:post, user:, content: 'Hello, World!', created_at: '2025-03-24 15:00:00') }

  it 'ポストのデータを閲覧することができる' do
    visit root_path

    expect(page).to have_selector 'h1', text: '全体タイムライン'
    expect(page).to have_content 'Hello, World!'
    expect(page).to have_content 'taji'
    expect(page).to have_content '2025/03/24 15:00'

    click_on 'Hello, World!'

    expect(page).to have_current_path post_path(post)
    expect(page).to have_content 'Hello, World!'
    expect(page).to have_content 'taji'
    expect(page).to have_content '2025/03/24 15:00'
  end
end
