class SwapRequestsController < ApplicationController
  before_action :set_swap_request, only: [:show, :edit, :update, :destroy]

  # GET /swap_requests
  # GET /swap_requests.json
  def index
    @swap_requests = SwapRequest.all
  end

  # GET /swap_requests/1
  # GET /swap_requests/1.json
  def show
  end

  # GET /swap_requests/new
  def new
    @swap_request = SwapRequest.new
  end

  # GET /swap_requests/1/edit
  def edit
  end

  # POST /swap_requests
  # POST /swap_requests.json
  def create
    @swap_request = SwapRequest.new(swap_request_params)
    @swap_request.user = current_user
    respond_to do |format|
      if @swap_request.save
        format.html { redirect_to @swap_request, notice: 'Swap request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @swap_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @swap_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swap_requests/1
  # PATCH/PUT /swap_requests/1.json
  def update
    respond_to do |format|
      if @swap_request.update(swap_request_params)
        format.html { redirect_to @swap_request, notice: 'Swap request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @swap_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swap_requests/1
  # DELETE /swap_requests/1.json
  def destroy
    @swap_request.destroy
    respond_to do |format|
      format.html { redirect_to swap_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_swap_request
      @swap_request = SwapRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def swap_request_params
      params.require(:swap_request).permit(:headcook_required, :message, :date, :isResolved?)
    end
end