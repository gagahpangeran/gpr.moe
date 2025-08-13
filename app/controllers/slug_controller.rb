class SlugController < ApplicationController
  allow_unauthenticated_access
  rate_limit to: 10, within: 1.minutes, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def root
    link = Link.find_by(slug: "/")

    if link
      link.increment!(:visit_count)
      url = link.url
    else
      url = root_url
    end

    redirect_to url, status: :moved_permanently, allow_other_host: true
  end

  def visit
    link = Link.find_by!(slug: params[:slug])
    link.increment!(:visit_count)
    redirect_to link.url, status: :moved_permanently, allow_other_host: true
  end
end
