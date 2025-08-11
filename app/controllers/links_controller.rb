class LinksController < ApplicationController
  def index
    @links = Current.user.links.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Current.user.links.new(link_params)

    if @link.save
      redirect_to links_path
    else
      error_message = @link.errors.full_messages.first if @link.errors.any?
      flash.now[:alert] = error_message || "Something went wrong."
      render :new, status: :unprocessable_content
    end
  end

  private
    def link_params
      params.expect(link: [ :url, :slug ])
    end
end
