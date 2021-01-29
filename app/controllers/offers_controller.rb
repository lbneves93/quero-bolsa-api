class OffersController < ApplicationController
  before_action :filter_params

  def index
      begin
        offers = Offer.includes(:course, campus: :university)
                      .where(where_params)
                      .order(order_params)
                      .as_json(
                        only: %i[full_price price_with_discount discount_percentage start_date enrollment_semester enabled],
                        include: { 
                          course: { only: %i[name kind level shift] }, 
                          campus: { only: %i[name city] },
                          university: { only: %i[name score logo_url] }
                        }
                      )
        render json: offers
      rescue ArgumentError => message
        render status: :bad_request, json: { error: message }
      end
  end

  private

  def filter_params
    begin
      @offers_params = params.permit(:price_with_discount, university: :name, course: %i[name kind level shift], campus: :city)
    rescue ActionController::UnpermittedParameters => message
      render status: :bad_request, json: { error: message }
    end
  end

  def where_params
    @offers_params.extract!(:university, :course, :campus)
  end

  def order_params
    @offers_params.extract!(:price_with_discount).to_hash
  end
end