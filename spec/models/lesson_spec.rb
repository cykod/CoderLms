require "rails_helper"

describe Lesson do

  let(:course) { create :course }

  describe "#set_number" do
    it "increases the number automatically" do
      lesson1 = create :lesson, course: course
      lesson2 = create :lesson, course: course

      expect(lesson1.number).to eq 1
      expect(lesson2.number).to eq 2
    end
  end

  describe "#set_permalink" do
    it "creates a valid permalink" do
      lesson = create :lesson, course: course, name: 'This is the Lesson!'
      expect(lesson.permalink).to eq "this-is-the-lesson"
    end

    it "adds a number when the permalink is the same in two lessons in the same course" do
      lesson = create :lesson, course: course, name: 'This is the Lesson!'
      lesson2 = create :lesson, course: course, name: 'This is the Lesson!'

      expect(lesson2.permalink).to eq "this-is-the-lesson-2"
    end

    it "has permalinks scoped to different courses" do
      course2 = create :course

      lesson = create :lesson, course: course, name: 'This is the Lesson!'
      lesson2 = create :lesson, course: course2, name: 'This is the Lesson!'

      expect(lesson2.permalink).to eq "this-is-the-lesson"
    end
  end
end
