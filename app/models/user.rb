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

  def final_grade
    assignments_weight = 0
    return 0 if user_assignments.length == 0
    final = self.user_assignments.preload(:lesson_assignment).map do |ua|
      assignments_weight += ua.lesson_assignment.weight
      ua.grade * (ua.lesson_assignment.weight||0)
    end.sum.to_f

    if assignments_weight > 0
      (final / assignments_weight).round
    else 
      0
    end
  end
end
