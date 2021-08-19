require 'rails_helper'

describe 'ログイン前のテスト' do
  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button ( I18n.t('dictionary.button.sign_up') )
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button ( I18n.t('dictionary.button.sign_up') ) }.to change(User.all, :count).by(1)
      end
      it '新規登録後、投稿一覧(search)に遷移する' do
        click_button ( I18n.t('dictionary.button.sign_up') )
        expect(current_path).to eq '/contents/search'
      end
    end

    context '新規登録失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button ( I18n.t('dictionary.button.sign_up') )
      end

      it '新規登録に失敗し、新規登録画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_up'
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button ( I18n.t('dictionary.button.log_in') )
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
      end

      it 'ログイン後、投稿一覧(search)に遷移する' do
        click_button ( I18n.t('dictionary.button.log_in') )
        expect(current_path).to eq '/contents/search'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: ''
        click_button ( I18n.t('dictionary.button.log_in') )
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end
end
