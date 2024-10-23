# README

# users テーブル

| Column             | Type   | Options                     |
| ------------------ | ------ | --------------------------- |
| nickname           | string | null: false, unique: true   |
| email              | string | null: false, unique: true   |
| password           | string | null: false                 |
| last_name          | string | null: false                 |
| first_name         | string | null: false                 |
| last_name_kana     | string | null: false                 |
| first_name_kana    | string | null: false                 |
| birth_date         | string | null: false                 |

### Association
has_many :items
has_many :orders
has_many :comments

## itemsテーブル

| Column            | Type      | Options                     |
| ----------------- | --------- | --------------------------- |
| name              | string    | null: false                 |
| description       | text      | null: false                 |
| price             | integer   | null: false                 |
| category_id       | integer   | null: false                 |
| condition_id      | integer   | null: false                 |
| shipping_fee_id   | integer   | null: false                 |
| shipping_region_id| integer   | null: false                 |
| shipping_days_id  | integer   | null: false                 |
| user              | references| null: false,foreign_key:true|

### Association
belongs_to :user
has_one :order
has_many :comments

## ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addressesテーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| region_id    | integer    | null: false                    |
| city         | string     | null: false                    |
| house_number | string     | null: false                    |
| building_name| string     | null: false                    |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association
belongs_to :order

##　commentsテーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| message      | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :item