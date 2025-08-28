class PagesController < ApplicationController
  def home
    @chat = Chat.new
    render :show
  end
end
