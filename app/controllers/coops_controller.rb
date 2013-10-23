class CoopsController < ApplicationController
  before_action :set_coop, only: [:show, :edit, :update, :destroy]

  # GET /coops
  # GET /coops.json
  def index
    @coops = Coop.all
  end

  # GET /coops/1
  # GET /coops/1.json
  def show
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop
      @coop = Coop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coop_params
      params.require(:coop).permit(:name)
    end
end
