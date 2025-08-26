class ChatsController < ApplicationController
  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(params[:chat])
    @chat.save
  end

  def show
    @chat = Chat.find(params[:id])
  end
end
