class OffersController < ApplicationController
  def index
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
  end

  private

  def where_params
    params.permit(university: :name, course: %i[name kind level shift], campus: :city)
  end

  def order_params
    params.permit(:price_with_discount).to_hash
  end
end