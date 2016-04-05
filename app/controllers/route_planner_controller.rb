class RoutePlannerController < ApplicationController
  def lookup_form
    @city_name_attributes = City.pluck(:name, :id)
  end

  def lookup; end
end
