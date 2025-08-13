class Admin::LinksController < Admin::BaseController
  before_action :set_link

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to admin_root_path, notice: "Root link is updated."
    else
      flash.now[:alert] = error_message
      render :edit, status: :unprocessable_content
    end
  end

  private
    def set_link
      @link = Link.find_by(slug: "/")
    end

    def link_params
      params.expect(link: [ :url ])
    end

    def error_message
      error_message = @link.errors.full_messages.first if @link.errors.any?
      error_message || "Something went wrong."
    end
end
