class DirectMessagesController < ApplicationController
  before_action :chatroom_config, only: %i[create]

  def create
    if @direct_message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "direct_message", locals: { direct_message: @direct_message })
      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@direct_message.id}")
    else
      render "chatrooms/show"
    end
    authorize @direct_message
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:content)
  end

  def chatroom_config
    @chatroom = Chatroom.find(params[:chatroom_id])
    @direct_message = DirectMessage.new(direct_message_params)
    @direct_message.chatroom = @chatroom
    @direct_message.user = current_user
  end
end
