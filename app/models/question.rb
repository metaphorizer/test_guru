class Question < ApplicationRecord
  belongs_to :test
  has_many :answers
  has_many :gists, dependent: :destroy

  validates :body, presence: true
end
