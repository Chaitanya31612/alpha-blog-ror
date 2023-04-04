include ActionView::Helpers::DateHelper

class MessagesController < ApplicationController
  before_action :require_user
  def index
    redirect_to "/community" if request.original_fullpath.include?("messages")
    @prev_messages = Message.all
    @message = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(msg_params)
    @message.user_id = current_user.id
    if @message.save
      ActionCable.server.
        broadcast('room_channel', {
          content: {
            data: @message.content,
            user: current_user,
            creation_time: time_ago_in_words(@message.created_at)
          }
        })
    end
  end


  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
