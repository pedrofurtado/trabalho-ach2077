class MedicalAppointmentsController < ApplicationController
  before_action :set_medical_appointment, only: [:show, :edit, :update, :destroy]

  # GET /medical_appointments
  def index
    @medical_appointments = MedicalAppointment.all
  end

  # GET /medical_appointments/1
  def show
  end

  # GET /medical_appointments/new
  def new
    @medical_appointment = MedicalAppointment.new
  end

  # GET /medical_appointments/1/edit
  def edit
  end

  def calendar
    @medical_appointments = MedicalAppointment.all.map do |medical_appointment|
      {
      id: "medical_appointment_#{medical_appointment.id}",
      title: "#{medical_appointment.patient.name} - #{medical_appointment.employee.name}",
      start: "#{medical_appointment.scheduled_at}T#{medical_appointment.start_time}:00+00:00",
      end: "#{medical_appointment.scheduled_at}T#{medical_appointment.finish_time}:00+00:00",
      url: medical_appointment_path(medical_appointment)
    }
    end.to_json.html_safe
  end

  # POST /medical_appointments
  def create
    @medical_appointment = MedicalAppointment.new(medical_appointment_params)

    if @medical_appointment.save
      redirect_to @medical_appointment, notice: 'Consulta criada com sucesso!'
    else
      render :new
    end
  end

  # PATCH/PUT /medical_appointments/1
  def update
    if @medical_appointment.update(medical_appointment_params)
      redirect_to @medical_appointment, notice: 'Consulta atualizada com sucesso!'
    else
      render :edit
    end
  end

  # DELETE /medical_appointments/1
  def destroy
    @medical_appointment.destroy
    redirect_to medical_appointments_url, notice: 'Consulta destruída com sucesso!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical_appointment
      @medical_appointment = MedicalAppointment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def medical_appointment_params
      params.require(:medical_appointment).permit(:patient_id, :employee_id, :scheduled_at, :start_time, :finish_time, :description)
    end
end
