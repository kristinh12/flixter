class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_course
    if current_user.enrolled_in?(current_lesson.section.course) != true
      redirect_to courses_path(current_lesson.section.course), alert: 'Not enrolled in the course'
    end
  end

end
