class ChatsController < ApplicationController

  # def index
  #   @chat = Chat.find(param[:chat_id])
  #   # @chats =  current_user.chats.where(challenge: @challenge)
  #   @message = Message.new
  # end


  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @chat = Chat.new(chat_title: Date.today.to_s)
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
