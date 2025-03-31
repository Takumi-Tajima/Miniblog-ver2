require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post, content: '他人の投稿') }

  before { sign_in user }

  it '投稿にいいねができること' do
    visit root_path

    expect(page).to have_selector 'h1', text: '全体タイムライン'
    expect(page).to have_content '他人の投稿'

    expect do
      find_by_id('like-button').click
      expect(page).to have_content 'いいねしました'
    end.to change(user.likes, :count).by(1)

    expect(page).to have_selector 'h1', text: '全体タイムライン'
    expect(page).to have_content '他人の投稿'
  end

  context 'すでにいいねをしている場合' do
    before { create(:like, user: user, post: post) }

    it 'いいねを外すことができること' do
      visit root_path

      expect(page).to have_selector 'h1', text: '全体タイムライン'
      expect(page).to have_content '他人の投稿'

      expect do
        find_by_id('unlike-button').click
        expect(page).to have_content 'いいねを解除しました'
      end.to change(user.likes, :count).by(-1)

      expect(page).to have_selector 'h1', text: '全体タイムライン'
      expect(page).to have_content '他人の投稿'
    end
  end

  describe 'いいねしたユーザーの一覧' do
    let(:sato) { create(:user, name: 'sato') }
    let(:suzuki) { create(:user, name: 'suzuki') }
    let(:takahashi) { create(:user, name: 'takahashi') }

    before do
      create(:like, user: sato, post: post)
      create(:like, user: suzuki, post: post)
      create(:like, user: takahashi, post: post)
    end

    it 'いいねしたユーザーの一覧が表示されること' do
      visit post_likes_path(post)

      expect(page).to have_selector 'h1', text: 'いいねしたユーザー'
      expect(page).to have_content 'sato'
      expect(page).to have_content 'suzuki'
      expect(page).to have_content 'takahashi'
    end
  end
end
