class ScholarshipsController < ApplicationController
  before_action :auth_required
  before_action :set_scholarship, only: [:show, :edit, :update, :destroy, :internship_request_file]

  # GET /scholarships
  # GET /scholarships.json
  def index
    redirect_to root_path
  end

  # GET /scholarships/1
  # GET /scholarships/1.json
  def show
  end

  # GET /scholarships/new
  def new
    @scholarship = Scholarship.new(percent:0)
  end

  # GET /scholarships/1/edit
  def edit
  end

  # POST /scholarships
  # POST /scholarships.json
  def create
    @scholarship = Scholarship.new(scholarship_params)
    @scholarship.status = Scholarship::REQUESTED
    @scholarship.max_amount = @scholarship.scholarship_type.max_amount
    @scholarship.amount = @scholarship.max_amount*(@scholarship.percent/100);

    respond_to do |format|
      if @scholarship.save
        format.html { redirect_to @scholarship, notice: 'Scholarship was successfully created.' }
        format.json { render :show, status: :created, location: @scholarship }
      else
        format.html { render :new, notice: @scholarships.errors }
        format.json { render json: @scholarship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scholarships/1
  # PATCH/PUT /scholarships/1.json
  def update
    respond_to do |format|
      if @scholarship.update(scholarship_params)
        format.html { redirect_to @scholarship, notice: 'Scholarship was successfully updated.' }
        format.json { render :show, status: :ok, location: @scholarship }
      else
        format.html { render :edit }
        format.json { render json: @scholarship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scholarships/1
  # DELETE /scholarships/1.json
  def destroy
    @scholarship.destroy
    respond_to do |format|
      format.html { redirect_to scholarships_url, notice: 'Scholarship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def internship_request_file
    pdf = Prawn::Document.new(background: "private/membretada2018.png", background_scale: 0.36, right_margin: 20)
    pdf.font_size 12
    # Cabecera
    text = "Coordinación de Estudios de Posgrado
         <b>FOLIO---</b>
          Chihuahua, Chih., a #{I18n.l(Date.today, format: '%d de %B del %Y')}"
    pdf.move_down 100
    pdf.text text,size:11, align: :right, inline_format:true

    # Destinatario
    text = "Lic. Nathanael Martínez Coronel \n Director de Administración y Finanzas \n CIMAV"
    pdf.move_down 10
    pdf.text text
    # Presente
    pdf.move_down 10
    pdf.text"<b>P r e s e n t e.-</b>", :size => 12, inline_format:true
    # contenido
    text = "Por este conducto y de la manera más atenta solicito se sirva generar apoyo de Beca para: <b>#{@scholarship.person.full_name}</b>"
    pdf.move_down 20
    pdf.text text, inline_format:true
    # tabla
    pdf.font_size 10
    pdf.move_down 30
    table_data = [['Actividad','Monto', 'Periodo','Responsable','Proyecto','No. solicitud'],
                  [@scholarship.person.internship_type.name,"$#{@scholarship.amount}","#{(I18n.l(@scholarship.start_date, format: '%B %Y')).capitalize} - #{(I18n.l(@scholarship.end_date, format: '%B %Y'))}", @scholarship.person.staff.full_name, '5432168', '']]
    pdf.table table_data, :position=>:center, header:true
    pdf.font_size 12
    text = "\n\n Sin más por el momento reciba un cordial saludo.."
    pdf.move_down 20
    pdf.text text, inline_format:true
    # nota
    text = "“EL BECARIO DECLARA BAJO PROTESTA DE DECIR VERDAD QUE NO RECIBE APOYOS SIMILARES POR PARTE DE CONACYT”"
    pdf.move_down 40
    pdf.text text, align: :center, inline_format:true, size:8
    # atentamente
    text = "Atentamente,"
    pdf.move_down 70
    pdf.text text, align: :center
    # firma
    text = "<b>Lic. Emilio Pascual Domínguez Lechuga \n Coordinador de Estudios de Posgrado</b>"
    pdf.move_down 40
    pdf.text text, align: :center, inline_format:true

    send_data pdf.render, filename: "Solicitud de beca#{@scholarship.id}.pdf", type: 'application/pdf', disposition: 'inline'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scholarship
      @scholarship = Scholarship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scholarship_params
      params.require(:scholarship).permit(:person_type, :person_id, :scholarship_type_id, :amount, :start_date, :end_date, :scholarship_type, :percent, :max_amount)
    end
end
