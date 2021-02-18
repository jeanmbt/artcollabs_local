class Project < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :keywords #You can also configure multiple tag types per model
  acts_as_favoritable

  has_many :collaborations, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }, uniqueness: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[open closed finished] }
  validates :budget, presence: true
  validates :max_members, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true
  validates :location, presence: true


end
