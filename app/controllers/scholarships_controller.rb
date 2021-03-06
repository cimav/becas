class ScholarshipsController < ApplicationController
  skip_before_action :auth_required, only: [:access_with_token, :upload_internship_file_with_token, :upload_student_file_with_token, :internship_files]
  before_action :set_scholarship, only: [:show, :edit, :update, :destroy, :print_internship_cep_file, :create_comment, :internship_files, :upload_internship_file, :upload_student_file, :upload_internship_file_with_token, :access_with_token, :send_to_committee, :change_status, :create_admin_note, :upload_scholarship_file, :upload_student_file_with_token, :student_files]
  include ActionView::Helpers::NumberHelper

  # GET /scholarships
  # GET /scholarships.json
  def index
    redirect_to root_path
  end

  # GET /scholarships/1
  # GET /scholarships/1.json
  def show
    @comments = @scholarship.scholarship_comments.where.not(status: ScholarshipComment::DELETED)
    @admin_notes = @scholarship.admin_notes.where.not(status: ScholarshipComment::DELETED)
  end

  # GET /scholarships/new
  def new
    @person = params[:scholarship_person_type]
    @scholarship = Scholarship.new
  end

  # GET /scholarships/1/edit
  def edit
  end

  # POST /scholarships
  # POST /scholarships.json
  def create
    @scholarship = Scholarship.new(scholarship_params)
    @scholarship.status = Scholarship::REQUESTED
    uma_value = UmaValue.last.value rescue 0
    if @scholarship.scholarship_type.in_umas
      @scholarship.max_amount = @scholarship.scholarship_type.umas_max_amount * uma_value
    else
      @scholarship.max_amount = @scholarship.scholarship_type.max_amount
    end

    @person = @scholarship.person_type

    respond_to do |format|
      if @scholarship.save

        @scholarship.notice_admin # se envía correo a los administradores para notificar nueva beca
        if @scholarship.person_type.eql? 'Internship'
          @scholarship.notice_student # se envía correo con token para para que el alumno accese
        end

        #se manda notificacion a administradores
        User.where(user_type:[User::ADMIN,User::SUPER_USER]).each {|person| person.notifications.create(message:"#{current_person.full_name} ha creado una nueva beca", notification_type: Notification::NEW_SCHOLARSHIP, link:"/scholarships/#{@scholarship.id}") if person != current_person}

        format.html {redirect_to @scholarship, notice: 'Beca creada'}
        format.json {render :show, status: :created, location: @scholarship}
      else
        format.html {render :new}
        format.json {render json: @scholarship.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /scholarships/1
  # PATCH/PUT /scholarships/1.json
  def update
    respond_to do |format|
      data = scholarship_params
      data[:max_amount] = ScholarshipType.find(data[:scholarship_type_id]).max_amount if data[:scholarship_type_id] != @scholarship.scholarship_type_id
      if @scholarship.update(data)
        format.html {redirect_to @scholarship, notice: 'Se actualizó la beca'}
        format.json {render :show, status: :ok, location: @scholarship}
      else
        format.html {render :edit}
        format.json {render json: @scholarship.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /scholarships/1
  # DELETE /scholarships/1.json
  def destroy
    @scholarship.update(status: Scholarship::DELETED)
    respond_to do |format|
      format.html {redirect_to scholarships_url, notice: 'Se eliminó la beca'}
      format.json {head :no_content}
    end
  end

  def print_internship_cep_file


    pdf = Prawn::Document.new(background: "private/membretada.png", background_scale: 0.36, right_margin: 20)
    pdf.font_size 12
    # Cabecera
    text = "Coordinación de Estudios de Posgrado
         <b>FOLIO---</b>
          Chihuahua, Chih., a #{I18n.l(Date.today, format: '%d de %B del %Y')}"
    pdf.move_down 100
    pdf.text text, size: 11, align: :right, inline_format: true

    # Destinatario
    text = "Lic. Nathanael Martínez Coronel \n Director de Administración y Finanzas \n CIMAV"
    pdf.move_down 10
    pdf.text text
    # Presente
    pdf.move_down 10
    pdf.text "<b>P r e s e n t e.-</b>", :size => 12, inline_format: true
    # contenido
    text = "Por este conducto y de la manera más atenta solicito se sirva generar apoyo de Beca para: <b>#{@scholarship.person.full_name}</b>"
    pdf.move_down 20
    pdf.text text, inline_format: true
    # tabla
    pdf.font_size 10
    pdf.move_down 30
    table_data = [['Actividad', 'Monto', 'Periodo', 'Responsable', 'Proyecto', 'No. solicitud'],
                  [@scholarship.person.internship_type.name, number_to_currency(@scholarship.amount, unit: "$", separator: ".", delimiter: ",", format: "%u%n"), "#{(I18n.l(@scholarship.start_date, format: '%B %Y')).capitalize} - #{(I18n.l(@scholarship.end_date, format: '%B %Y')).capitalize}", @scholarship.person.staff.full_name, (@scholarship.project_number rescue ''), (@scholarship.request_number rescue '')]]
    pdf.table table_data, :position => :center, header: @person = 'Internship'
    true
    pdf.font_size 12
    text = "\n\n Por lo anterior le solicito de la manera más atenta se sirva a generar el apoyo correspondiente."
    pdf.move_down 20
    pdf.text text, inline_format: true
    # nota
    text = "“EL BECARIO DECLARA BAJO PROTESTA DE DECIR VERDAD QUE NO RECIBE APOYOS SIMILARES POR PARTE DE CONACYT”"
    pdf.move_down 40
    pdf.text text, align: :center, inline_format: true, size: 8
    # atentamente
    text = "Atentamente,"
    pdf.move_down 70
    pdf.text text, align: :center
    # firma
    text = "<b>Lic. Emilio Pascual Domínguez Lechuga \n Coordinador de Estudios de Posgrado</b>"
    pdf.move_down 40
    pdf.text text, align: :center, inline_format: true

    send_data pdf.render, filename: "Solicitud de beca#{@scholarship.id}.pdf", type: 'application/pdf', disposition: 'inline'
  end

  def create_comment
    comment = @scholarship.scholarship_comments.new(content: params[:scholarship_comment][:content])
    if is_admin?
      comment.person = current_user
    else
      comment.person = current_staff
    end
    if comment.save
      #se enviará una notificación al docente responsable, al asistente y a los administradores
      persons = []
      if @scholarship.person_type == 'Internship'
        persons.push(@scholarship.person.staff) if @scholarship.person.staff
        User.where.not(status: User::DELETED).where(user_type: [User::DEPARTMENT_ASSISTANT, User::DEPARTMENT_CHIEF]).each {|user| persons.push(user) if @scholarship.person.area.id.in? user.areas} rescue ''
      else
        User.where.not(status: User::DELETED).where(user_type: [User::DEPARTMENT_ASSISTANT, User::DEPARTMENT_CHIEF]).each {|user| persons.push(user) if @scholarship.person.supervisor.area.id.in? user.areas} rescue ''
        persons.push(@scholarship.person.supervisor) if @scholarship.person.supervisor
      end
      User.where.not(status: User::DELETED).where(user_type: [User::ADMIN, User::SUPER_USER]).each {|user| persons.push(user)}

      persons.each {|person| person.notifications.create(message:"Nuevo mensaje de #{current_person.full_name}", notification_type: Notification::MESSAGE, link:"/scholarships/#{@scholarship.id}") if person != current_person}
      redirect_to @scholarship
    end
  end

  def create_admin_note
    comment = @scholarship.admin_notes.new(content: params[:admin_note][:content])

    comment.user = current_user
    if comment.save
      User.where(user_type:[User::ADMIN,User::SUPER_USER]).each {|person| person.notifications.create(message:"#{current_person.full_name} ha escrito una nota de administrador", notification_type: Notification::ADMIN_NOTE, link:"/scholarships/#{@scholarship.id}") if person != current_person}
      redirect_to @scholarship
    end
  end

  def change_status
    respond_to do |format|
     if @scholarship.update(status: params[:scholarship][:status])
        format.html {redirect_to @scholarship, notice: 'Se actualizó la beca'}
        format.json {render :show, status: :ok, location: @scholarship}
      else
        format.html {render :edit}
        format.json {render json: @scholarship.errors, status: :unprocessable_entity}
      end
    end
  end

  def internship_files
    @files = @scholarship.person.internship_files
    render layout: false
  end

  def student_files
    @files = @scholarship.person.student_files
    render layout: false
  end

  def upload_internship_file
    response = {}
    file = InternshipFile.new
    file.internship_id = @scholarship.person.id
    file.file_type = params[:internship_file]['file_type']
    file.file = params[:internship_file]['file']
    file.description = params[:internship_file]['file'].original_filename rescue 'Sin nombre'
    response[:object] = file
    respond_to do |format|
      if file.save
        format.html {redirect_to "/scholarships/#{@scholarship.id}?target=internship-files", notice: 'Se subió el documento'}
        format.json {head :no_content}
      else
        format.html {redirect_to @scholarship, notice: 'Error al subir documento'}
        format.json {head :no_content}
      end
    end
  end

  def upload_student_file
    response = {}
    file = StudentFile.new
    file.student_id = @scholarship.person.id
    file.file_type = params[:student_file]['file_type']
    file.file = params[:student_file]['file']
    file.description = params[:student_file]['file'].original_filename rescue 'Sin nombre'
    response[:object] = file
    respond_to do |format|
      if file.save
        format.html {redirect_to "/scholarships/#{@scholarship.id}?target=student-files", notice: 'Se subió el documento'}
        format.json {head :no_content}
      else
        format.html {redirect_to @scholarship, notice: 'Error al subir documento'}
        format.json {head :no_content}
      end
    end
  end

  def upload_internship_file_with_token
    token = ScholarshipToken.find_by_token(params[:token])
    response = {}
    file = InternshipFile.new
    file.internship_id = @scholarship.person.id
    file.file_type = params[:internship_file]['file_type']
    file.file = params[:internship_file]['file']
    file.description = params[:internship_file]['file'].original_filename rescue 'Sin nombre'
    response[:object] = file
    respond_to do |format|
      if token.status.eql? ScholarshipToken::ACTIVE
        if file.save
          message = 'Se subió el documento'
        else
          message = 'Error al subir documento'
        end
      else
        message = 'Se ha cerrado la carga de documentos'
      end
      format.html {redirect_to "/scholarships/#{@scholarship.id}/token/#{token.token}", notice: message}
      format.json {head :no_content}
    end
  end

  def upload_student_file_with_token
    token = ScholarshipToken.find_by_token(params[:token])
    response = {}
    file = StudentFile.new
    file.student_id = @scholarship.person.id
    file.file_type = params[:internship_file]['file_type']
    file.file = params[:internship_file]['file']
    file.description = params[:internship_file]['file'].original_filename rescue 'Sin nombre'
    response[:object] = file
    respond_to do |format|
      if token.status.eql? ScholarshipToken::ACTIVE
        if file.save
          message = 'Se subió el documento'
        else
          message = 'Error al subir documento'
        end
      else
        message = 'Se ha cerrado la carga de documentos'
      end
      format.html {redirect_to "/scholarships/#{@scholarship.id}/token/#{token.token}", notice: message}
      format.json {head :no_content}
    end
  end

  def access_with_token
    @token = params[:token]
    render layout: 'empty_layout'
  end

  def send_to_committee
    meeting_id = params[:meeting_id]
    notes = params[:notes]

    agreement = @scholarship.build_agreement(meeting_id: meeting_id, notes: notes, notification_sent: Agreement::NOT_SENT)
    respond_to do |format|
      if agreement.save
        @scholarship.status = Scholarship::TO_COMMITTEE
        @scholarship.save
        message = 'Acuerdo enviado a comité'
      else
        message = 'Error al crear acuerdo'
      end
      format.html {redirect_to scholarships_url, notice: message}
      format.json {head :no_content}
    end
  end

  def upload_scholarship_file
    response = {}
    file = @scholarship.scholarship_files.new
    file.file_type = params[:scholarship_file]['file_type']
    file.file = params[:scholarship_file]['file']
    file.name = params[:scholarship_file]['file'].original_filename rescue 'Sin nombre'
    response[:object] = file
    respond_to do |format|
      if file.save
        format.html {redirect_to @scholarship, notice: 'Se subió el documento'}
        format.json {head :no_content}
      else
        format.html {redirect_to scholarships_url, notice: 'Error al subir documento'}
        format.json {head :no_content}
      end
    end
  end

  def get_scholarship_file
    file = ScholarshipFile.find(params[:id])
    send_file file.file.to_s, disposition: :inline
  end

  def delete_scholarship_file
    file = ScholarshipFile.find(params[:id])
    scholarship = file.scholarship
    respond_to do |format|
      if file.destroy
        format.html {redirect_to scholarship, notice: 'Se eliminó el archivo'}
        format.json {head :no_content}
      else
        format.html {redirect_to scholarship, notice: 'Error al eliminar archivo'}
        format.json {head :no_content}
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scholarship
    @scholarship = Scholarship.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scholarship_params
    params.require(:scholarship).permit(:person_type, :person_id, :scholarship_type_id, :category, :amount, :start_date, :end_date, :scholarship_type, :max_amount, :project_number, :request_number, :notes)
  end
end
