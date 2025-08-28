class PagesController < ApplicationController
  def home
    @chat = Chat.new
  end

  def chat
  end
end
