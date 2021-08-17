# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }#userを作りdbに値を保持する(itが実行される前)
    let(:user) { build(:user) }#userをオブジェクトとして作る(userの呼び出し時)

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '一意性があること' do
        user.email = other_user.email
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Contentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:contents).macro).to eq :has_many
      end
    end
  end
end