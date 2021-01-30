# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :request do
  describe 'GET /courses' do
    let!(:first_university) { create(:university, name: 'PUC') }
    let!(:first_course) { create(:course, kind: 'presential', level: 'bachelor', shift: 'morning') }
    let!(:second_course) { create(:course, kind: 'distance learning', level: 'bachelor', shift: 'night') }
    let!(:first_campus) { create(:campus, university: first_university, courses: [first_course]) }
    let!(:second_campus) { create(:campus, university: first_university, courses: [second_course]) }

    let!(:second_university) { create(:university, name: 'Inatel') }
    let!(:third_course) { create(:course, kind: 'presential', level: 'technologist', shift: 'morning') }
    let!(:third_campus) { create(:campus, university: second_university, courses: [third_course]) }

    let(:params) { nil }

    before do
      get(courses_path, params: params)
      @response_body = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of courses' do
      expect(@response_body.count).to eq(3)
    end

    it 'returns correct json structure' do
      expect(@response_body.first).to include(
        name: first_course.name,
        kind: first_course.kind,
        level: first_course.level,
        shift: first_course.shift,
        campus: [
          {
            name: first_campus.name,
            city: first_campus.city,
            university: {
              name: first_university.name,
              score: first_university.score.to_s,
              logo_url: first_university.logo_url
            }
          }
        ]
      )
    end

    context 'when filtering by university name' do
      let!(:params) { { university: { name: 'PUC' } } }
      it 'returns courses from PUC' do
        expect(@response_body.count).to eq(2)
        expect(@response_body.first[:name]).to eq(first_course.name)
        expect(@response_body.last[:name]).to eq(second_course.name)
      end
    end

    context 'when filtering by kind' do
      let!(:params) { { kind: 'presential' } }
      it 'returns courses with presential kind' do
        expect(@response_body.count).to eq(2)
        expect(@response_body.first[:name]).to eq(first_course.name)
        expect(@response_body.last[:name]).to eq(third_course.name)
      end
    end

    context 'when filtering by level' do
      let!(:params) { { level: 'technologist' } }
      it 'returns courses with technologist level' do
        expect(@response_body.count).to eq(1)
        expect(@response_body.first[:name]).to eq(third_course.name)
      end
    end

    context 'when filtering by shift' do
      let!(:params) { { shift: 'night' } }
      it 'returns courses with night shift' do
        expect(@response_body.count).to eq(1)
        expect(@response_body.first[:name]).to eq(second_course.name)
      end
    end

    context 'with invalid param' do
      let!(:params) { { invalid_param: :invalid_value } }
      it 'returns http bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
