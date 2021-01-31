# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffersController, type: :request do
  describe 'GET /offers' do
    let!(:first_university) { create(:university, name: 'PUC') }
    let!(:first_course) do
      create(:course, name: 'Computer Science', kind: 'presential', level: 'bachelor', shift: 'morning')
    end
    let!(:second_course) do
      create(:course, name: 'Administration', kind: 'distance learning', level: 'bachelor', shift: 'night')
    end
    let!(:first_campus) do
      create(:campus, city: 'Poços de Caldas', university: first_university, courses: [first_course])
    end
    let!(:second_campus) do
      create(:campus, city: 'São José dos Campos', university: first_university, courses: [second_course])
    end
    let!(:first_offer) { create(:offer, price_with_discount: 1950.30, campus: first_campus, course: first_course) }
    let!(:second_offer) { create(:offer, price_with_discount: 1970.10, campus: second_campus, course: second_course) }

    let!(:second_university) { create(:university, name: 'Inatel') }
    let!(:third_course) do
      create(:course, name: 'Computer Science', kind: 'presential', level: 'technologist', shift: 'morning')
    end
    let!(:third_campus) do
      create(:campus, city: 'São José dos Campos', university: second_university, courses: [third_course])
    end
    let!(:third_offer) { create(:offer, price_with_discount: 1550.00, campus: third_campus, course: third_course) }

    let(:params) { nil }
    let(:user) { create(:user, username: 'admin', password: '123456', age: 28) }

    before do
      get(offers_path, params: params, headers: authenticated_header(user))
      @response_body = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of offers' do
      expect(@response_body.count).to eq(3)
    end

    it 'returns correct json structure' do
      expect(@response_body.first).to include(
        full_price: first_offer.full_price.to_s,
        price_with_discount: first_offer.price_with_discount.to_s,
        discount_percentage: first_offer.discount_percentage,
        start_date: first_offer.start_date.to_s,
        enrollment_semester: first_offer.enrollment_semester,
        enabled: first_offer.enabled,
        course: {
          name: first_course.name,
          kind: first_course.kind,
          level: first_course.level,
          shift: first_course.shift
        },
        university: {
          name: first_university.name,
          score: first_university.score.to_s,
          logo_url: first_university.logo_url
        },
        campus: {
          name: first_campus.name,
          city: first_campus.city
        }
      )
    end

    context 'when filtering by course name' do
      let!(:params) { { course: { name: 'Computer Science' } } }
      it 'returns offers from Computer Science' do
        expect(@response_body.count).to eq(2)
        expect(@response_body.first[:course][:name]).to eq(first_course.name)
        expect(@response_body.last[:course][:name]).to eq(third_course.name)
      end
    end

    context 'when filtering by university name' do
      let!(:params) { { university: { name: 'Inatel' } } }
      it 'returns offers from Inatel' do
        expect(@response_body.count).to eq(1)
        expect(@response_body.first[:university][:name]).to eq(second_university.name)
      end
    end

    context 'when filtering by course city' do
      let!(:params) { { campus: { city: 'Poços de Caldas' } } }
      it 'returns offers from Poços de Caldas' do
        expect(@response_body.count).to eq(1)
        expect(@response_body.first[:campus][:city]).to eq(first_campus.city)
      end
    end

    context 'when filtering by course kind' do
      let!(:params) { { course: { kind: 'presential' } } }
      it 'returns offers with presential kind' do
        expect(@response_body.count).to eq(2)
        expect(@response_body.first[:course][:name]).to eq(first_course.name)
        expect(@response_body.last[:course][:name]).to eq(third_course.name)
      end
    end

    context 'when filtering by course level' do
      let!(:params) { { course: { level: 'technologist' } } }
      it 'returns offers for technologist level' do
        expect(@response_body.count).to eq(1)
        expect(@response_body.first[:course][:name]).to eq(third_course.name)
      end
    end

    context 'when filtering by course shift' do
      let!(:params) { { course: { shift: 'night' } } }
      it 'returns offers for night shift' do
        expect(@response_body.count).to eq(1)
        expect(@response_body.first[:course][:name]).to eq(second_course.name)
      end
    end

    context 'when ordering by max to min price_with_discount' do
      let!(:params) { { price_with_discount: :desc } }
      it 'returns offers ordered by max to min price_with_discount' do
        expect(@response_body.count).to eq(3)
        expect(@response_body.first[:price_with_discount]).to eq(second_offer.price_with_discount.to_s)
        expect(@response_body.second[:price_with_discount]).to eq(first_offer.price_with_discount.to_s)
        expect(@response_body.third[:price_with_discount]).to eq(third_offer.price_with_discount.to_s)
      end
    end

    context 'when ordering by min to max price_with_discount' do
      let!(:params) { { price_with_discount: :asc } }
      it 'returns offers ordered by min to max price_with_discount' do
        expect(@response_body.count).to eq(3)
        expect(@response_body.first[:price_with_discount]).to eq(third_offer.price_with_discount.to_s)
        expect(@response_body.second[:price_with_discount]).to eq(first_offer.price_with_discount.to_s)
        expect(@response_body.third[:price_with_discount]).to eq(second_offer.price_with_discount.to_s)
      end
    end

    context 'with invalid price_with_discount order value' do
      let!(:params) { { price_with_discount: :invalid } }
      it 'returns http bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with invalid param' do
      let!(:params) { { invalid_param: :invalid_value } }
      it 'returns http bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'without authorization' do
      it 'returns unauthorized response' do
        get(offers_path)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
