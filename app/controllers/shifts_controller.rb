class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy, :add_user, :remove_user, :add_user_pic]
  before_action :set_coop, only: [:add_user, :remove_user, :add_user_pic]

  # adds the current user to this shift
  def add_user
    @user = current_user
    if @user.pic
      puts @shift.inspect
      render partial: 'shift_pic_confirm_deny'
    else
      unless @shift.users.include?(@user)
        @shift.users << @user
        render partial: 'add_remove_show', shift: @shift, notice: 'Successfully joined shift.'
      else
        render partial: 'add_remove_show', shift: @shift, notice: 'You\'re already on this shift.'
      end
    end
  end

  def add_user_pic
    @user = current_user
    pic = params[:pic]
    unless @shift.users.include?(@user)
      @shift.leader = @user.id
      @shift.save
      @shift.users << @user
      @shift.meals.each do |meal|
        meal.head_cook = @user.id
        meal.save
      end
      render partial: 'add_remove_show', shift: @shift, notice: 'Successfully joined shift.'
    else
      render partial: 'add_remove_show', shift: @shift, notice: 'You\'re already on this shift.'
    end
  end

  # remove the current user from this shift
  def remove_user
    @user = current_user
    if @shift.users.include?(@user)
      @shift.users.delete(@user)
      # make sure we're no longer the leader
      if @shift.leader == @user.id
        @shift.leader = nil
        if @shift.save
          @shift.meals.each do |meal|
            meal.head_cook = nil
            meal.save
          end
          render partial: 'add_remove_show', shift: @shift, notice: 'Successfully removed from shift.'
        else
          render partial: 'add_remove_show', shift: @shift, notice: "Couldn't remove you"
        end
      else
        render partial: 'add_remove_show', shift: @shift, notice: "Successfully removed from shift."
      end
    else
      render partial: 'add_remove_show', shift: @shift, notice: "You were never on this shift."
    end
  end

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(shift_params)
    # Set user, coop, leader
    @shift.users << current_user
    @shift.coop_id = current_user.coop_id
    if shift_params[:isLeader] == "yes"
      @shift.leader = current_user.id
    else
      @shift.leader = nil
    end

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shift }
      else
        format.html { render action: 'new' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    # Set the shift's leader
    if shift_params[:isLeader] == "yes"
      @shift.leader = current_user.id
    else
      @shift.leader = nil
    end

    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def set_coop
      @coop = Coop.find(params[:coop_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:coop_id, :day, :start_time, :end_time, :activity, :isLeader)
    end
end
