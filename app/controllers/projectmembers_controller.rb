class ProjectmembersController < ApplicationController
  def index
    @projectmembers = Projectmember.all
  end
end