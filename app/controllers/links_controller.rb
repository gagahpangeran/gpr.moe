class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]

  def index
    @links = Current.user.links.all.order(created_at: :desc)
  end

  def show
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
  end

  def update
    if @link.visit_count > 5
      flash.now[:alert] = "Link can't be changed."
      return render :edit, status: :forbidden
    end

    if @link.update(link_params)
      redirect_to link_path(@link), notice: "Link is updated."
    else
      flash.now[:alert] = error_message
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @link.update(url: nil)
      redirect_to links_path, notice: "Link is deleted."
    else
      flash.now[:alert] = error_message
      render :edit, status: :unprocessable_content
    end
  end

  private
    def set_link
      @link = Current.user.links.find(params[:id])
    end

    def link_params
      params.expect(link: [ :url, :slug ])
    end

    def error_message
      error_message = @link.errors.full_messages.first if @link.errors.any?
      error_message || "Something went wrong."
    end
end
