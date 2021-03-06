class Admin::NotificationsController < AdminController
  respond_to :html, :json, :js

  def index
    @notifications = Notification.order('delivery_start DESC').page(params[:page])
    respond_with @notifications
  end

  def phone
    @phone_number = params[:id]
    @notifications = Notification.where( :phone_number => @phone_number ).page(params[:page])
    respond_with @notifications
  end

  def search
    redirect_to admin_notifications_phone_url phone_normalize(params[:phone])
  end

  def show
    @notification = Notification.find(params[:id])
    @notifier_id = @notification.notifier.id
    @notifier_name = @notification.notifier.username
    @attempts = @notification.delivery_attempts
    @message = @notification.message
    respond_with @notification
  end

  def new
    @notification = Notification.new
    respond_with :admin, @notification
  end

  def edit
    @notification = Notification.find(params[:id])
    respond_with :admin, @notification
  end

  def create
    @notification = Notification.new
    @notification.attributes = params[:notification]
    @notification.uuid ||= UUID.generate
    @notification.delivery_start ||= Time.zone.now
    @notification.save
    respond_with :admin, @notification
  end

  def update
    @notification = Notification.find(params[:id])
    @notification.update_attributes(params[:notification])
    respond_with :admin, @notification
  end

end
