class RunsController < ApplicationController
require 'message_sender'

  def new
    @run = Run.new
    @dogs = current_user.dogs
    @run.address = current_user.address
  end

  def create
    @run = Run.new(run_params)
    @run.user_id = 1
    @run.appointment = Time.now

    @run.price = @run.duration/2 + 10
    if @run.save
      send_initial_notification(@run)
      redirect_to confirm_path(@run)
    else
      puts @run.errors.full_messages
      render :new
    end
  end

  def confirm_edit
    @run = Run.find(params[:id])
    @dog = @run.dog
  end

  def confirm_update
    @run = Run.find(params[:id])
    @run.status = 1
    if @run.save
      flash[:notice] = "Your booking request was recieved!"
      redirect_to @run
    else
      render :confirm_edit, alert: "Error creating booking."
    end
  end

  def show
    @run = Run.find(params[:id])
    @user = User.find(@run.user_id)
    @dog = Dog.find(@run.dog_id)
  end

  def index
    # if you have a dog and he has had a run before
    if current_user.dogs != [] && Run.all.select { |r| r.dog_id == current_user.dogs.first.id } != []
    # select all the runs of your dog
     @runs = Run.all.select { |r| r.dog_id == current_user.dogs.first.id }
     # get the runner (for displaying him on the index page)
     @user = User.find(@runs.first.user_id)
     # get the dog for displaying him too
     @dog = Dog.find(@runs.first.dog_id)
    else
      redirect_to root_path
    end
  end

  def send_initial_notification(run)
    message = "Hey #{run.dog.user.first_name} need someone to run #{run.dog.name}"
    notify(message)
  end

private


  def notify(message)
    MessageSender.send_message(
      @run.id, "placeholder for phone number", message)
  end

  def redirect_with_error
    message = "An error has occurred updating the order status"
    redirect_to orders_url, flash: { error: message }
  end

  def load_run
    @run = Run.find(params[:id])
  end

  def record_not_found
    render 'shared/404', status: 404, layout: false
  end

  def run_params
    params.require(:run).permit(:dog_id, :status, :appointment, :duration, :price, :note, :park_id, :address, :longitude, :latitude)
  end

end
