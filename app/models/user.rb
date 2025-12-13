class User < ApplicationRecord
  has_many :praises
  validates :nickname, presence: true
end
