class ProjectChat < ApplicationRecord
  belongs_to :project
  has_many :messages, dependent: :destroy
end
