class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :set_coop, only: [:new, :create, :edit]

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

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new
    @meal.update(@meal.from_params(meal_params))
    puts @meal.inspect
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:meal_type, :isSpecial, :name, :cancelled, :discussion_info, :meal_info, :end_time_no_date, :start_time_no_date, :date)
    end
end
