class Campus < ApplicationRecord
  belongs_to :university
  has_many :campus_courses, class_name: 'CampusCourses'
  has_many :courses, through: :campus_courses
end
