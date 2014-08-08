class Goal < ActiveRecord::Base
  validates :body, :setting, :user, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :goals
  )

  include Commentable

end
