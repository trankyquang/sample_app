class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_length}
  validate :picture_size

  scope :order_by_day, -> {order(created_at: :desc)}
  scope :load_new_feeds, -> following_ids, user_id do
    where("user_id IN (?) OR user_id = ?",following_ids, user_id)
  end

  private
  def picture_size
    if picture.size > Settings.micropost.capacity_of_picture.megabytes
      errors.add :picture, t("should_be_less_than_5MB")
    end
  end
end
