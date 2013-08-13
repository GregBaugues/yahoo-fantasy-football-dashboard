class ProjectionsController < ActionController

  def index
    @projections = Projections.where(week).order("standard DESC")
  end

end