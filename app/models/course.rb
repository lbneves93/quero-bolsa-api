# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :offers, dependent: :destroy
  has_many :campus_courses, class_name: 'CampusCourses', dependent: :destroy
  has_many :campus, through: :campus_courses
end
