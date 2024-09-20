class Student < ApplicationRecord
  belongs_to :user
  before_validation :find_or_update_existing_student

  private

  def find_or_update_existing_student
    existing_student = Student.find_by(name: name, subject: subject)

    if existing_student
      existing_student.update(marks: existing_student.marks + self.marks)
      throw(:abort)
    end
  end
end