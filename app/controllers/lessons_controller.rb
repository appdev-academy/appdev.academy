class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find_by!(slug: params[:slug])
  end
end
