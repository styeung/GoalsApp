class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token
  after_initialize :add_cheers

  attr_reader :password

  has_many(
    :goals,
    class_name: "Goal",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )

  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :author
  )

  include Commentable

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    return nil if @user.nil?

    return @user if @user.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def add_cheers(num = 10)
    self.cheers = num
    self.save
  end

end
