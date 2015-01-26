require "rails_helper"

describe CourseSession do

  let(:course1) { create :course }
  let(:course2) { create :course }


  let(:course_session) { create :course_session, course: course1, name: "Web 2 Spring 2015" }

  describe "#set_permalink" do
    it "creates a valid permalink" do
      expect(course_session.permalink).to eq "web-2-spring-2015"
    end

    it "creates globally unique permalinks" do
      course_session 
      course_session2 = create :course_session, course: course1, name: "Web 2 Spring 2015"
      expect(course_session2.permalink).to eq "web-2-spring-2015-2"
    end
  end

  describe ".fetch" do
    it "returns a session" do
      expect(CourseSession.fetch(course_session.permalink)).to eq course_session
    end
  end

  describe "#access?" do
    it "returns true for admin users" do
      user = create :user, admin: true
      expect(course_session.access?(user)).to eq true
    end

    it "returns false for non-admins without a user course session" do
      user = create :user
      expect(course_session.access?(user)).to eq false
    end

    it "returns true for admins with a session" do
      user = create :user
      create :user_course_session, user: user, course_session: course_session
      expect(course_session.access?(user)).to eq true
    end
  end
end
