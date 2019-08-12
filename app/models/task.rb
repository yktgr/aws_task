class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence:true
  validates :content, presence:true
  enum priority: {low: 0, middle: 1, high:2, top:3}
  scope :expired, -> {order(expired_at: :desc)}
  scope :priority, -> {order(priority: :desc)}
  scope :search_title, -> (title){where('title Like ?',"%#{title}%")}
  scope :search_status, -> (status){where('status = ?',status)}
  scope :search_all,-> (title,status){where('title Like ? and status = ?',"%#{title}%",status)}
end
