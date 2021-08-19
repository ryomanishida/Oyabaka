# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { content.valid? }

    let(:user) { create(:user) }
    let!(:content) { build(:content, user_id: user.id) }

    context 'imgカラム' do
      it '選択されていること' do
        content.img = ''
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        content.title = ''
        is_expected.to eq false
      end
      it '70文字以下であること: 70文字は〇' do
        content.title = Faker::Lorem.characters(number: 70)
        is_expected.to eq true
      end
      it '70文字以下であること: 71文字は×' do
        content.title = Faker::Lorem.characters(number: 71)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '140文字以下であること: 140文字は〇' do
        content.introduction = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '140文字以下であること: 141文字は×' do
        content.introduction = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Content.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
