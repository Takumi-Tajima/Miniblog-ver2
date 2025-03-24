require 'rails_helper'

RSpec.describe 'ポストの閲覧', type: :system do
  before { create(:post, content: 'Hello, World!', created_at: '2025-03-24 15:00:00') }

  it '全体タイムライン画面でポストのデータを閲覧することができる' do
    visit root_path

    expect(page).to have_selector 'h1', text: '全体タイムライン'
    expect(page).to have_content 'Hello, World!'
    expect(page).to have_content '2025/03/24 15:00'
  end
end
