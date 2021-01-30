# frozen_string_literal: true

class Campus < ApplicationRecord
  belongs_to :university
  has_many :campus_courses, class_name: 'CampusCourses', dependent: :destroy
  has_many :courses, through: :campus_courses
  has_many :offers, dependent: :destroy
end
