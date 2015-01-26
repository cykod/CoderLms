class User < ActiveRecord::Base

  has_many :user_course_session
  has_many :course_sessions, through: :user_course_session
  has_many :user_assignments
  
  def self.fetch(auth_hash)
    user = User.where(uid: auth_hash.uid).first || User.new
    user.attributes = { 
      uid: auth_hash.uid,
      username: auth_hash.info.nickname,
      name: auth_hash.info.name,
      email: auth_hash.info.email
    }

    user.sign_in_count += 1
    user.current_sign_in_at = Time.now

    user.save && user
  end
end
