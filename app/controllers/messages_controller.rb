class MessagesController < ApplicationController
  before_action :set_chat, only: %i[new create]

  def new
    # @chat = Chat.find(params[:chat_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.chat = @chat
    if @message.save
      redirect_to chat_path(@chat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
