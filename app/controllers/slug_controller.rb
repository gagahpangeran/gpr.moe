class SlugController < ApplicationController
  allow_unauthenticated_access

  def visit
    link = Link.find_by(slug: params[:slug])

    if link
      link.increment!(:visit_count)
      redirect_to link.url, status: :moved_permanently, allow_other_host: true
    else
      head :not_found
    end
  end
end
