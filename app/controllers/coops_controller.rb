class CoopsController < ApplicationController
  before_action :set_coop, only: [:show, :edit, :update, :destroy, :generate_member_join_link, :generate_admin_join_link, :join_coop_page, :member_join, :admin_join]
  before_action :force_admin, only: [:edit, :update, :destroy, :generate_member_join_link, :generate_admin_join_link]

  include CoopsHelper

  # GET /coops
  # GET /coops.json
  def index
    if current_user
      redirect_to coop_path(current_user.coop)
    end
    @coops = Coop.all
  end

  # GET /coops/1
  # GET /coops/1.json
  def show
    bs = Meal.where(coop: @coop, meal_type: 'breakfast', start_time: (Date.today..Date.today + 7)).order('start_time asc')
    ls = Meal.where(coop: @coop, meal_type: 'lunch', start_time: (Date.today..Date.today + 7)).order('start_time asc')
    ds = Meal.where(coop: @coop, meal_type: 'dinner', start_time: (Date.today..Date.today + 7)).order('start_time asc')
    @days = weekFromToday;
    @breakfasts = {}
    @lunches = {}
    @dinners = {}
    @days.each do |day|
      @breakfasts[day] = []
      while bs[0] && bs[0].day == day
        @breakfasts[day] << bs.shift
      end
      @lunches[day] = []
      while ls[0] && ls[0].day == day
        @lunches[day] << ls.shift
      end
      @dinners[day] = []
      while ds[0] && ds[0].day == day
        @dinners[day] << ds.shift
      end
    end
    @user = current_user
  end

  # GET /coops/new
  def new
    @coop = Coop.new
  end

  # GET /coops/1/edit
  def edit
  end

  # POST /coops
  # POST /coops.json
  def create
    @coop = Coop.new(coop_params)
    respond_to do |format|
      if @coop.save
        format.html { redirect_to @coop, notice: 'Coop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coop }
      else
        format.html { render action: 'new' }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coops/1
  # PATCH/PUT /coops/1.json
  def update
    respond_to do |format|
      if @coop.update(coop_params)
        if Meal.where(coop: @coop)
          Meal.update_meals_for_coop(coop_params, @coop)
        else
          Meal.generate_meals_for_coop(coop_params, @coop)
        end
        format.html { redirect_to @coop, notice: 'Coop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coops/1
  # DELETE /coops/1.json
  def destroy
    @coop.destroy
    respond_to do |format|
      format.html { redirect_to coops_url }
      format.json { head :no_content }
    end
  end

  def generate_member_join_link
    respond_to do |format|
      @coop.update_member_join_hash
      if @coop.save
        UserMailer.coop_join_info_email(current_user, @coop).deliver
        format.html { redirect_to edit_coop_path(@coop), notice: 'Email sent!' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_coop_path(@coop), notice: 'Something went wrong' }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_admin_join_link
    respond_to do |format|
      @coop.update_admin_join_hash
      if @coop.save
        UserMailer.coop_admin_email(current_user, @coop).deliver
        format.html { redirect_to edit_coop_path(@coop), notice: 'Email sent!' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_coop_path(@coop), notice: 'Something went wrong' }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  def member_join
    unless params[:member_join_hash] == @coop.member_join_hash
      redirect_to root_path
      return
    end
    session[:coop_id] = @coop.id
    session[:return_to] = 'new member'
    puts session[:return_to]
    redirect_to "/auth/google_login"
  end

  def admin_join
    unless params[:admin_join_hash] == @coop.admin_join_hash
      redirect_to root_path
      return
    end
    session[:coop_id] = @coop.id
    session[:return_to] = 'new admin'
    redirect_to "/auth/google_login"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop
      @coop = Coop.find(params[:id])
    end

    def force_admin
      unless current_user && current_user.admin?
        redirect_to @coop, notice: 'Must be a coop admin to modify coop'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coop_params
      params.require(:coop).permit(:name, :bfast_time, :lunch_time, :dinner_time, :monday_breakfast, :tuesday_breakfast, :wednesday_breakfast, :thursday_breakfast, :friday_breakfast, :saturday_breakfast, :sunday_breakfast, :monday_lunch, :tuesday_lunch, :wednesday_lunch, :thursday_lunch, :friday_lunch, :saturday_lunch, :sunday_lunch, :monday_dinner, :tuesday_dinner, :wednesday_dinner, :thursday_dinner, :friday_dinner, :saturday_dinner, :sunday_dinner)
    end
end
