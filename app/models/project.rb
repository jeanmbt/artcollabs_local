class Project < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :tags #You can also configure multiple tag types per model

  #validate :start_date_cannot_be_in_the_past
  #validate :end_date_cannot_be_before_start_date

  has_many :collaborations, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_one_attached :photo, dependent: :destroy

  # validates :photo, size: { less_than: 100.megabytes , message: 'The image should not be larger than 100 MB' }
  # class_name: "Title_Pic"
  has_many_attached :media, dependent: :destroy
  # class_name: "Media_files"
  has_one :project_chat, dependent: :destroy

  # we can also add audio and video using cloudinary (both use video on the tag), need some config apparently. hints:
  # has_many_attached :audios, resource_type: video ,dependent: :destroy
  # <%= cl_video_tag @i..., controls: true, style: "width: 100%;" %>

  validates :title, presence: true, length: { maximum: 80 }, uniqueness: true
  # validates :description, presence: true
  # validates :status, presence: true, inclusion: { in: %w[open active closed finished] }
  # validates :budget, presence: true
  # validates :max_members, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true
  # validates :location, presence: true

  after_create :initialize_project_chat

  STATUS = ['High', 'Medium', 'Low', 'None']

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "The start date cannot be in the past")
    end
  end

  def end_date_cannot_be_before_start_date
    if end_date < start_date
      errors.add(:end_date, "The end date needs to be before the start date")
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_title_budget_location_and_description,
    against: [ :title, :budget, :location, :description ],
    using: {
      tsearch: { prefix: true }
    }

  private

  def initialize_project_chat
    self.project_chat = ProjectChat.create(project: self)
  end
end
