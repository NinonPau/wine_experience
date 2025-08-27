class ChatsController < ApplicationController
  def new
    @chat = Chat.new
    @message = Message.new
  end

  def create
    @chat = Chat.new(params[:id])
    @chat.save
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end
end
