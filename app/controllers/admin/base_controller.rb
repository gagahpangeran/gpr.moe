class Admin::BaseController < ApplicationController
  admin_access_only
end
