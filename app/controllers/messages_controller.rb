class MessagesController < ApplicationController
  before_action :set_previous_page, only: %i[ destroy confirm deny ]

  def create
    message_config
    if @message.save
      ProjectChatChannel.broadcast_to(
        @project_chat,
        render_to_string(partial: "message", locals: { message: @message })
      )
    else
      redirect_to session.delete(:return_to)
    end
    authorize @message
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_previous_page
    session[:return_to] ||= request.referer
  end

  def message_config
    @project_chat = ProjectChat.find(params[:project_chat_id])
    @message = Message.new(message_params)
    @message.project_chat = @project_chat
    @message.user = current_user
  end
end
