class PagesController < ApplicationController
  slip_before_action :require_login, only: [:index]

  def top
  end

  def about
  end
end
