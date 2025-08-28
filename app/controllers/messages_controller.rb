class MessagesController < ApplicationController
  before_action :set_chat, only: %i[new create]

  SYSTEM_PROMPT = <<~PROMPT
    You are a Sommelier.

    I am a person looking for wine recommendations or general information.

    Give me the name, region, vintage, grape type, and taste profile.

    Answer consicely with bullet points in markdown.

  PROMPT

  def new
    # @chat = Chat.find(params[:chat_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @chat = Chat.find(params[:chat_id])
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      @response = RubyLLM.chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "Maître Sommelier", content: @response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # def instructions
  #   [SYSTEM_PROMPT, @chat.challenge.system_prompt].compact.join("\n\n")
  # end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
