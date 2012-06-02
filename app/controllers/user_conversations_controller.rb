class UserConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_data, :only => [:create]
  before_filter :get_recipient, :only => [:new, :create]

  helper_method :mailbox, :conversation
  def index

  end

  def show
    @conversation = conversation
  end

  def new
  end

  def create
    @receipt = current_user.send_message(@recipient, params[:body], params[:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      redirect_to user_conversation_path(@conversation)
    else
      flash[:error] = I18n.t('msg.fail')
      render :action => :new
    end
  end

  def reply
    current_user.reply_to_conversation(conversation, params[:body], params[:subject])
    redirect_to user_conversation_path(@conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :user_conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :user_conversations
  end

  private

  def check_data
    if params[:body].blank?
      flash[:error] = I18n.t('user_conversations.create.empty', :input => 'Nachricht')
      render :new and return
    end
    if params[:subject].blank?
      flash[:error] = I18n.t('user_conversations.create.empty', :input => 'Betreff')
      render :new and return
    end
  end

  def get_recipient
    unless @recipient = User.find_by_id(params[:id])
      flash[:error] = I18n.t('msg.not_found')
      redirect_to user_conversations_path and return
    end
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

end
