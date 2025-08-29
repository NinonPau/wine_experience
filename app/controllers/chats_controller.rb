class ChatsController < ApplicationController

  # def index
  #   @chat = Chat.find(param[:chat_id])
  #   # @chats =  current_user.chats.where(challenge: @challenge)
  #   @message = Message.new
  # end


  def show
    @chat = Chat.find(params[:id])
    # @chat = Chat.includes(:messages).find(params[:id])
    if Rails.env.development?
      @input_tokens = @chat.messages.pluck(:input_tokens).compact.sum
      @output_tokens = @chat.messages.pluck(:output_tokens).compact.sum
      @context_window = RubyLLM.models.find(@chat.model_id).context_window
    end
    @message = Message.new
  end

  def create
    @chat = Chat.new(chat_title: Date.today.to_s , model_id: "gpt-4.1-nano")
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
