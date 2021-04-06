class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true,
    uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    end
  end

end
