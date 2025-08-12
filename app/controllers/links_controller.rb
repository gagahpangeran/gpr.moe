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
      redirect_to links_path, notice: "New slug added."
    else
      flash.now[:alert] = error_message
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @link = Current.user.links.find(params[:id])
  end

  def update
  end

  private
    def link_params
      params.expect(link: [ :url, :slug ])
    end

    def error_message
      error_message = @link.errors.full_messages.first if @link.errors.any?
      error_message || "Something went wrong."
    end
end
