class CoursesController < ApplicationController
  def index
    courses = Course.includes(campus: :university)
                    .where(courses_params)
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

  def courses_params
    params.permit(:kind, :level, :shift, university: :name)
  end
end