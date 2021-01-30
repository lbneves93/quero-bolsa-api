# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :filter_params

  def index
    courses = Course.includes(campus: :university)
                    .where(@courses_params)
                    .as_json(
                      only: %i[name kind level shift],
                      include: {
                        campus: {
                          only: %i[name city],
                          include: {
                            university: {
                              only: %i[name score logo_url]
                            }
                          }
                        }
                      }
                    )
    render json: courses
  end

  private

  def filter_params
    @courses_params = params.permit(:kind, :level, :shift, university: :name)
  rescue ActionController::UnpermittedParameters => e
    render status: :bad_request, json: { error: e }
  end
end
