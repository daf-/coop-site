class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :check_for_user, only: [:edit, :update, :destroy, :edit_mult]
  before_action :set_coop, only: [:new, :create, :edit, :edit_mult]
  before_action :is_admin, only: [:edit_mult, :update_mult]

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    time = DateTime.now.change(min: 0)
    @meal = Meal.new({start_time: time, end_time: time + (60*60)})
  end

  # GET /meals/1/edit
  def edit
  end

  def edit_mult
  end

  def update_mult
    puts lunch_params
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new
    @meal.update(@meal.from_params(meal_params))
    @meal.coop = @coop
    respond_to do |format|
      if @meal.save
        format.html { redirect_to coop_path(@meal.coop), notice: 'Meal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(@meal.from_params(meal_params))
        format.html { redirect_to coop_path(@meal.coop), notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def set_coop
      @coop = Coop.find(params[:coop_id]);
    end

    def check_for_user
      unless current_user
        redirect_to @coop, notice: 'Must be signed in to do that'
      end
    end

    def is_admin
      unless current_user.admin?
        redirect_to root_path, notice: 'Must be admin to do that!'
      end
    end

    def breakfast_params
      unless params[:breakfast]
        return nil
      end
      params.permit(:breakfast_hour, :breakfast_min, :breakfast_ampm, :monday_breakfast, :tuesday_breakfast, :wednesday_breakfast, :thursday_breakfast, :friday_breakfast, :saturday_breakfast, :sunday_breakfast, :kp_breakfast, :cook_1, :cook_2, :pre_crew, :crew, :custom_shift_1_b, :custom_shift_2_b, :custom_shift_3_b)
    end

    def lunch_params
      unless params[:lunch]
        return nil
      end
      params.permit(:lunch_hour, :lunch_min, :lunch_ampm, :monday_lunch, :tuesday_lunch, :wednesday_lunch, :thursday_lunch, :friday_lunch, :saturday_lunch, :sunday_lunch, :kp_breakfast, :cook_1, :cook_2, :pre_crew, :crew, :custom_shift_1_l, :custom_shift_2_l, :custom_shift_3_l)
    end

    def dinner_params
      unless params[:dinner]
        return nil
      end
      params.permit(:dinner_hour, :dinner_min, :dinner_ampm, :monday_dinner, :tuesday_dinner, :wednesday_dinner, :thursday_dinner, :friday_dinner, :saturday_dinner, :sunday_dinner, :kp_breakfast, :cook_1, :cook_2, :pre_crew, :crew, :custom_shift_1_d, :custom_shift_2_d, :custom_shift_3_d)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:meal_type, :isSpecial, :name, :cancelled, :discussion_info, :meal_info, :end_time_no_date, :start_time_no_date, :date)
    end
end
