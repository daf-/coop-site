class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :check_for_user, only: [:edit, :update, :destroy, :edit_mult]
  before_action :set_coop, only: [:new, :create, :edit, :edit_mult, :update_mult]
  before_action :is_admin, only: [:edit_mult, :update_mult]
  before_action :set_selected

  include TimeHelper

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
    update_hash = @coop.set_meals_shifts(coop_meal_shift_params)
    update_hash.merge!(@coop.set_non_meal_shifts(coop_non_meal_shift_params))
    if @coop.update(update_hash)
      if @coop.update(coop_params)
        if (breakfast_params)
          if breakfast_params == 'delete'
            Meal.delete_all('breakfast', @coop)
            @coop.no_meal('breakfast')
          else
            @breakfasts = Meal.makeMeals('breakfast', breakfast_params, @coop)
          end
        end
        if (lunch_params)
          if lunch_params == 'delete'
            Meal.delete_all('lunch', @coop)
            @coop.no_meal('lunch')
          else
            @lunches = Meal.makeMeals('lunch', lunch_params, @coop)
          end
        end
        if (dinner_params)
          if dinner_params == 'delete'
            Meal.delete_all('dinner', @coop)
            @coop.no_meal('dinner')
          else
            @dinners = Meal.makeMeals('dinner', dinner_params, @coop)
          end
        end
        if (commando_params)
          if commando_params == 'delete'
            Shift.delete_all('commando', @coop)
            @coop.no_shift('commando')
          else
            Shift.make_shifts('commando', commando_params, @coop)
          end
        end
        if (mid_crew_params)
          if mid_crew_params == 'delete'
            Shift.delete_all('mid_crew', @coop)
            @coop.no_shift('mid_crew')
          else
            Shift.make_shifts('mid_crew', mid_crew_params, @coop)
          end
        end
        if (other_shift_params)
          if other_shift_params == 'delete'
            Shift.delete_all('other_shift', @coop)
            @coop.no_shift('other_shift')
          else
            Shift.make_shifts('other_shift', other_shift_params, @coop)
          end
        end

        @coop.save

        redirect_to @coop, notice: 'Successfully added meals and shifts'
      else
        redirect_to edit_coop_path(@coop), notice: 'Failed to update coop'
      end
    else
      redirect_to edit_coop_path(@coop), notice: 'Failed to update coop'
    end
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
      @meal.user = current_user
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
        return 'delete'
      end
      bp = params.permit(:breakfast_hour, :breakfast_min, :breakfast_ampm, :monday_breakfast, :tuesday_breakfast, :wednesday_breakfast, :thursday_breakfast, :friday_breakfast, :saturday_breakfast, :sunday_breakfast, :kp_breakfast, :cook_1_breakfast, :cook_2_breakfast, :pre_crew_breakfast, :crew_breakfast, :custom_shift_1_b, :custom_shift_2_b, :custom_shift_3_b)
      bp['time'] = time_from_select(bp[:breakfast_hour], bp[:breakfast_min], bp[:breakfast_ampm])
      bp
    end

    def lunch_params
      unless params[:lunch]
        return 'delete'
      end
      lp = params.permit(:lunch_hour, :lunch_min, :lunch_ampm, :monday_lunch, :tuesday_lunch, :wednesday_lunch, :thursday_lunch, :friday_lunch, :saturday_lunch, :sunday_lunch, :kp_lunch, :cook_1_lunch, :cook_2_lunch, :pre_crew_lunch, :crew_lunch, :custom_shift_1_l, :custom_shift_2_l, :custom_shift_3_l)
      lp['time'] = time_from_select(lp[:lunch_hour], lp[:lunch_min], lp[:lunch_ampm])
      lp
    end

    def dinner_params
      unless params[:dinner]
        return 'delete'
      end
      dp = params.permit(:dinner_hour, :dinner_min, :dinner_ampm, :monday_dinner, :tuesday_dinner, :wednesday_dinner, :thursday_dinner, :friday_dinner, :saturday_dinner, :sunday_dinner, :kp_dinner, :cook_1_dinner, :cook_2_dinner, :pre_crew_dinner, :crew_dinner, :custom_shift_1_d, :custom_shift_2_d, :custom_shift_3_d)
      dp['time'] = time_from_select(dp[:dinner_hour], dp[:dinner_min], dp[:dinner_ampm])
      dp
    end

    def coop_params
      pcp = params.permit(:member_descrip, :public_descrip, :other_shift_name, :custom_shift_1_l, :custom_shift_2_l, :custom_shift_3_l, :custom_shift_1_b, :custom_shift_2_b, :custom_shift_3_b, :custom_shift_1_d, :custom_shift_2_d, :custom_shift_3_d)
      pcp['bfast_time'] = breakfast_params['time'] if breakfast_params
      pcp['lunch_time'] = lunch_params['time'] if lunch_params
      pcp['dinner_time'] = dinner_params['time'] if dinner_params
      pcp['commando_time'] = commando_params['time'] if commando_params
      pcp['mid_crew_time'] = mid_crew_params['time'] if mid_crew_params
      pcp['other_shift_time'] = other_shift_params['time'] if other_shift_params
      pcp
    end

    def coop_meal_shift_params
      params.permit(:monday_lunch, :tuesday_lunch, :wednesday_lunch, :thursday_lunch, :friday_lunch, :saturday_lunch, :sunday_lunch, :kp_lunch, :cook_1_lunch, :cook_2_lunch, :pre_crew_lunch, :crew_lunch, :monday_breakfast, :tuesday_breakfast, :wednesday_breakfast, :thursday_breakfast, :friday_breakfast, :saturday_breakfast, :sunday_breakfast, :kp_breakfast, :cook_1_breakfast, :cook_2_breakfast, :pre_crew_breakfast, :crew_breakfast, :monday_dinner, :tuesday_dinner, :wednesday_dinner, :thursday_dinner, :friday_dinner, :saturday_dinner, :sunday_dinner, :kp_dinner, :cook_1_dinner, :cook_2_dinner, :pre_crew_dinner, :crew_dinner)
    end

    def coop_non_meal_shift_params
      params.permit(:monday_commando, :tuesday_commando, :wednesday_commando, :thursday_commando, :friday_commando, :saturday_commando, :sunday_commando, :monday_mid_crew, :tuesday_mid_crew, :wednesday_mid_crew, :thursday_mid_crew, :friday_mid_crew, :saturday_mid_crew, :sunday_mid_crew, :monday_other_shift, :tuesday_other_shift, :wednesday_other_shift, :thursday_other_shift, :friday_other_shift, :saturday_other_shift, :sunday_other_shift)
    end

    def commando_params
      unless params[:commando]
        return 'delete'
      end
      commando = params.permit(:commando_hour, :commando_min, :commando_ampm, :monday_commando, :tuesday_commando, :wednesday_commando, :thursday_commando, :friday_commando, :saturday_commando, :sunday_commando)
      commando['time'] = time_from_select(commando[:commando_hour], commando[:commando_min], commando[:commando_ampm])
      commando
    end

    def mid_crew_params
      unless params[:mid_crew]
        return 'delete'
      end
      mid_crew = params.permit(:mid_crew_hour, :mid_crew_min, :mid_crew_ampm, :monday_mid_crew, :tuesday_mid_crew, :wednesday_mid_crew, :thursday_mid_crew, :friday_mid_crew, :saturday_mid_crew, :sunday_mid_crew)
      mid_crew['time'] = time_from_select(mid_crew[:mid_crew_hour], mid_crew[:mid_crew_min], mid_crew[:mid_crew_ampm])
      mid_crew
    end

    def other_shift_params
      unless params[:other_shift]
        return 'delete'
      end
      other_shift = params.permit(:other_shift_name, :other_shift_hour, :other_shift_min, :other_shift_ampm, :monday_other_shift, :tuesday_other_shift, :wednesday_other_shift, :thursday_other_shift, :friday_other_shift, :saturday_other_shift, :sunday_other_shift)
      other_shift['time'] = time_from_select(other_shift[:other_shift_hour], other_shift[:other_shift_min], other_shift[:other_shift_ampm])
      other_shift
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:meal_type, :isSpecial, :name, :cancelled, :discussion_info, :meal_info, :end_time_no_date, :start_time_no_date, :date)
    end

    def set_selected
      @selected = 'calendar'
    end
end
