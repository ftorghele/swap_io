class UserConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_recipient, :only => [:new, :create]
  before_filter :get_box, :only => [:index, :trash, :untrash]
  after_filter :mark_as_read, :only => [:show]

  helper_method :mailbox, :conversation

  def index
    @messages = current_user.mailbox.send(@box)
  end

  def show
    @messages = conversation.receipts_for(current_user)
  end

  def new
  end

  def create
    @receipt = current_user.send_message(@recipient, params[:body], params[:subject])
    if (@receipt.errors.blank? && !params[:body].blank? && !params[:subject].blank?)
      @conversation = @receipt.conversation
      redirect_to user_conversation_path(@conversation)
    else
      flash_error
      render :action => :new
    end
  end

  def reply
    @receipt = current_user.reply_to_conversation(conversation, params[:body], params[:subject])
    if (@receipt.errors.blank? && !params[:body].blank? && !params[:subject].blank?)
      redirect_to user_conversation_path(@conversation)
    else
      flash_error
      redirect_to user_conversation_path(@conversation, :body => params[:body], :subject => params[:subject])
    end
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to user_conversations_path(:box => @box)
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to user_conversations_path(:box => @box)
  end

  private

  def flash_error
    if params[:body].blank?
      flash[:error] = I18n.t('user_conversations.create.empty', :input => 'Nachricht')
    elsif params[:subject].blank?
      flash[:error] = I18n.t('user_conversations.create.empty', :input => 'Betreff')
    else
      flash[:error] = I18n.t('msg.fail')
      get_recipient
    end
  end

  def get_recipient
    unless @recipient = User.find_by_id(params[:recipient_id])
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

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
      return
    end
    @box = params[:box]
  end

  def mark_as_read
    @messages.mark_as_read
  end

end
