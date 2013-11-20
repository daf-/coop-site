class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_coop, only: [:show, :edit]
  before_action :is_same_user, only: [:edit, :update, :show]
  before_action :is_admin, only: [:destroy]

  def home
    unless current_user
      render action: 'index'
    else
      redirect_to coop_path(current_user.coop_id)
    end
  end

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @selected = 'shifts'
    @swap_requests = @coop.swap_requests
  end

  def edit_shifts
    @selected = 'shifts'
    @user = User.find(params[:user_id])
    is_same_user
    @coop = @user.coop
    @days = normal_week_lowercase;
    @breakfasts = {}
    @lunches = {}
    @dinners = {}
    @others = {}
    @days.each do |day|
      @breakfasts[day] = []
      @lunches[day] = []
      @dinners[day] = []
      @others[day] = []
      shifts = Shift.where(coop: @coop, day: day)
      shifts.each do |shift|
        if shift.meals && shift.meals.first
          meal_type = shift.meals.first.meal_type
          if meal_type == 'breakfast'
            @breakfasts[day] << shift
          elsif meal_type == 'lunch'
            @lunches[day] << shift
          elsif meal_type == 'dinner'
            @dinners[day] << shift
          else
            @others[day] << shift
          end
        else
          @others[day] << shift
        end
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @selected = 'edit_user'
    @hide_nav_links = (@user.username == nil || @user.username == '')
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to signout_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop
      @coop = @user.coop
    end

    def set_user
      @user = User.find(params[:id])
    end

    def is_same_user
      unless @user.id == current_user.id
        redirect_to root_path, notice: 'Cannot edit other users'
      end
    end

    def is_admin
      unless current_user.admin?
        redirect_to root_path, notice: 'Must be admin to do that!'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :phone, :display_email, :display_phone)
    end
end
