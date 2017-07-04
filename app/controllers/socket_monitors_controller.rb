class SocketMonitorsController < ApplicationController
  before_action :set_socket_monitor, only: [:show, :edit, :update, :destroy]

  # GET /socket_monitors
  # GET /socket_monitors.json
  def index
    @socket_monitors = SocketMonitor.all
  end

  # GET /socket_monitors/1
  # GET /socket_monitors/1.json
  def show
  end

  # GET /socket_monitors/new
  def new
    @socket_monitor = SocketMonitor.new
  end

  # GET /socket_monitors/1/edit
  def edit
  end

  # POST /socket_monitors
  # POST /socket_monitors.json
  def create
    @socket_monitor = SocketMonitor.new(socket_monitor_params)

    respond_to do |format|
      if @socket_monitor.save
        format.html { redirect_to @socket_monitor, notice: 'Socket monitor was successfully created.' }
        format.json { render :show, status: :created, location: @socket_monitor }
      else
        format.html { render :new }
        format.json { render json: @socket_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socket_monitors/1
  # PATCH/PUT /socket_monitors/1.json
  def update
    respond_to do |format|
      if @socket_monitor.update(socket_monitor_params)
        format.html { redirect_to @socket_monitor, notice: 'Socket monitor was successfully updated.' }
        format.json { render :show, status: :ok, location: @socket_monitor }
      else
        format.html { render :edit }
        format.json { render json: @socket_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socket_monitors/1
  # DELETE /socket_monitors/1.json
  def destroy
    @socket_monitor.destroy
    respond_to do |format|
      format.html { redirect_to socket_monitors_url, notice: 'Socket monitor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_socket_monitor
      @socket_monitor = SocketMonitor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def socket_monitor_params
      params.require(:socket_monitor).permit(:el_socket_id, :current_sensor_id, :voltage_sensor_id, :nominal_voltage, :active, :frequency)
    end
end
