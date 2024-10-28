FactoryBot.define do
  factory :user do
    nickname { 'Test User' }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_date { '1990-01-01' }
    email { Faker::Internet.unique.email } # ユニークなメールアドレスを生成
    password { 'password1' }
    password_confirmation { 'password1' }
  end
end
