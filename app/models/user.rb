class User < ActiveRecord::Base

  has_many :votes
  has_many :nodes
  has_many :comments


  attr_accessible :dob, :email, :hashed_password, :salt, :username


  attr_accessor :password

  validates_presence_of :username
  validates_length_of :username, :within => 3..25
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_length_of :email, :maximum => 100
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates_format_of :email, :with => EMAIL_REGEX
  validates_confirmation_of :email

  validates_length_of :password, :within => 8..25, :on => :create

  before_save :create_hashed_password
  after_save :clear_password

  attr_protected :hashed_password, :salt


  def self.authenticate(username="", password="")
    user = User.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end


  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end


  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end


  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  def send_new_password
    new_pass = User.random_string(15)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end

  private
  def create_hashed_password
    unless password.blank?
      self.salt = User.make_salt(username) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end


  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    new_pass = ""
    1.upto(len) { |i| new_pass << chars[rand(chars.size-1)] }
    return new_pass
  end



end
