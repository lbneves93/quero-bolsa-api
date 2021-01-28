class Course < ApplicationRecord
  has_many :offers
  has_many :campus_courses, class_name: 'CampusCourses'
  has_many :campus, through: :campus_courses
end
