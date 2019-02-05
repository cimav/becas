class ScholarshipTypesController < ApplicationController
  before_action :set_scholarship_type, only: [:show, :edit, :update, :destroy]

  # GET /scholarship_types
  # GET /scholarship_types.json
  def index
    @scholarship_types = ScholarshipType.where.not(status:ScholarshipType::DELETED)
  end

  # GET /scholarship_types/1
  # GET /scholarship_types/1.json
  def show
  end

  # GET /scholarship_types/new
  def new
    @scholarship_type = ScholarshipType.new
  end

  # GET /scholarship_types/1/edit
  def edit
  end

  # POST /scholarship_types
  # POST /scholarship_types.json
  def create
    @scholarship_type = ScholarshipType.new(scholarship_type_params)

    respond_to do |format|
      if @scholarship_type.save
        format.html { redirect_to scholarship_types_path, notice: 'Tipo de beca creado' }
        format.json { render :show, status: :created, location: @scholarship_type }
      else
        format.html { render :new }
        format.json { render json: @scholarship_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scholarship_types/1
  # PATCH/PUT /scholarship_types/1.json
  def update
    respond_to do |format|
      if @scholarship_type.update(scholarship_type_params)
        format.html { redirect_to scholarship_types_path, notice: 'Tipo de beca actualizado.' }
        format.json { render :show, status: :ok, location: @scholarship_type }
      else
        format.html {
          flash[:alert] = @scholarship_type.errors.full_messages
          render :edit }
        format.json { render json: @scholarship_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scholarship_types/1
  # DELETE /scholarship_types/1.json
  def destroy
    respond_to do |format|
      if @scholarship_type.update(status:ScholarshipType::DELETED)
        format.html { redirect_to scholarship_types_url, notice: 'Se eliminó el tipo de beca' }
        format.json { head :no_content }
      else
        format.html { redirect_to scholarship_types_url, notice: 'Error al eliminar tipo de beca' }
        format.json { head :no_content }
      end
    end
  end

  def update_uma
    respond_to do |format|
      if UmaValue.create(value:params[:uma_value][:value])
        format.html { redirect_to scholarship_types_url, notice: 'Se actualizó el valor de la UMA' }
        format.json { head :no_content }
      else
        format.html { redirect_to scholarship_types_url, notice: 'Error al actualizar el valor de la UMA' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scholarship_type
      @scholarship_type = ScholarshipType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scholarship_type_params
      params.require(:scholarship_type).permit(:name, :description, :max_amount, :in_umas, :umas_max_amount)
    end
end
