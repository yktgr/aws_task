require 'rails_helper'
RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  scenario "タスク一覧のテスト" do
    visit root_path
    expect(page).to have_content 'Factoryタイトル1'
    expect(page).to have_content 'Factoryコンテント1'
    expect(page).to have_content '01-01'
    expect(page).to have_content 'Factoryタイトル2'
    expect(page).to have_content 'Factoryコンテント2'
    expect(page).to have_content '02-01'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'タスク名', with: 'title_test'
    fill_in '内容', with: 'content_test'
    fill_in '終了期限', with: '1/31'
    select '未着手',from:'ステータス'
    select '低',from: '優先度'
    click_button '登録する'
    expect(page).to have_content 'content_test'
  end

  scenario "タスク詳細のテスト" do
    visit root_path
    all('tr')[3].click_link '詳細'
    expect(page).to have_content 'Factoryコンテント2'
    visit root_path
    all('tr')[2].click_link '詳細'
    expect(page).to have_content 'Factoryコンテント1'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit root_path
     expect(Task.order("created_at DESC").map(&:id)).to eq [13, 12, 11]
  end

  scenario "タスクが終了期限の降順に並んでいるかのテスト" do
    visit root_path
    click_link "終了期限でソートする"
    expect(Task.order("expired_at DESC").map(&:id)).to eq [16, 15, 14]
  end

  scenario "タスクが優先度の降順に並んでいるかのテスト" do
    visit root_path
    click_link "優先度でソートする"
    expect(Task.order("priority DESC").map(&:id)).to eq [19, 18, 17]
  end
end
