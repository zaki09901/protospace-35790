class Comment < ApplicationRecord
  belongs_to :prototype #prototypeテーブルとのアソシエーション
  belongs_to :user      #userテーブルとのアソシエーション
  validates :text, presence: true
end
