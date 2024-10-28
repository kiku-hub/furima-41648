require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる場合' do
      it '必要な属性がすべて存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字混合で入力してください')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字混合で入力してください')
      end

      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = 'password1'
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '全角のpasswordでは登録できないこと' do
        @user.password = 'パスワード' # 全角のパスワード
        @user.password_confirmation = 'パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字混合で入力してください') # エラーメッセージの確認
      end

      it '重複しているemailでは登録できないこと' do
        FactoryBot.create(:user, email: @user.email) # 既存のユーザーを作成
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken') # エラーメッセージの確認
      end

      it 'emailに@が含まれていないと登録できないこと' do
        @user.email = 'testexample.com' # @を含まないメールアドレス
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid') # エラーメッセージの確認
      end

      # 姓名に関する追加テスト
      it 'last_nameに半角文字が含まれている場合は登録できないこと' do
        @user.last_name = 'Yamada' # 半角文字を含む姓
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角文字で入力してください') # エラーメッセージの確認
      end

      it 'first_nameに半角文字が含まれている場合は登録できないこと' do
        @user.first_name = 'Taro' # 半角文字を含む名
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字で入力してください') # エラーメッセージの確認
      end

      # フリガナに関する追加テスト
      it 'last_name_kanaにカタカナ以外の文字が含まれている場合は登録できないこと' do
        @user.last_name_kana = 'やまだ' # ひらがなを含む姓フリガナ
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください') # エラーメッセージの確認
      end

      it 'first_name_kanaにカタカナ以外の文字が含まれている場合は登録できないこと' do
        @user.first_name_kana = 'たろう' # ひらがなを含む名フリガナ
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください') # エラーメッセージの確認
      end

      it 'last_name_kanaに漢字が含まれている場合は登録できないこと' do
        @user.last_name_kana = '山田' # 漢字を含む姓フリガナ
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください') # エラーメッセージの確認
      end

      it 'first_name_kanaに漢字が含まれている場合は登録できないこと' do
        @user.first_name_kana = '太郎' # 漢字を含む名フリガナ
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください') # エラーメッセージの確認
      end
    end
  end
end
