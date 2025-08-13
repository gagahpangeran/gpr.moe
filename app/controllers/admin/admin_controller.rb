class Admin::AdminController < Admin::BaseController
  def index
    @root_link = Link.find_by(slug: "/")
  end
end
