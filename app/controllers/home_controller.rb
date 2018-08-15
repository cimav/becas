class HomeController < ApplicationController

  def index
    student = params[:student]
    if session[:user_type].eql? 'User'
      if is_admin?
        internship_ids = Internship.where("first_name LIKE '%#{student}%'").or(Internship.where("last_name LIKE '%#{student}%'")).pluck(:id)
        student_ids = Student.where("first_name LIKE '%#{student}%'").or(Student.where("last_name LIKE '%#{student}%'")).pluck(:id)
        @scholarships = Scholarship.where.not(status: Scholarship::DELETED).limit(10)
      elsif current_user.user_type.in? [User::DEPARTMENT_ASSISTANT, User::DEPARTMENT_CHIEF]
        @scholarships = Scholarship.where.not(status: Scholarship::DELETED).where(person_type: 'Internship').where(person_id: Internship.where(area: current_user.areas).pluck(:id))
      end
      render template: 'home/user_index'
    else


      # se ordena por estatus de manera personalizada
      @scholarships = Scholarship.where(person_type: 'Internship').where.not(status: Scholarship::DELETED).where(person_id: (Internship.where(staff_id: current_staff.id).pluck(:id)))
      render template: 'home/staff_index'
    end

    puts '----------------------'
    puts session[:user_type]
    puts '----------------------'

  end

  def load_scholarships
    ###################### Se reciben los parámetros
    scholarships_loaded = params[:scholarships_loaded].to_i
    student_name = params[:search_object][:student]
    staff_id = params[:search_object][:staff]
    area_id = params[:search_object][:area]
    scholarship_type_id = params[:search_object][:type]
    status = params[:search_object][:status]
    amount = params[:search_object][:amount]

    student_ids = []
    internship_ids = []


    # Se obtiene array con los ids de estudiantes que coincidan con los filtros de nombre, docente responsable y área
    if !staff_id.blank?
      if !area_id.blank?
        s = Student.where(supervisor:Staff.where(area_id:area_id).pluck(:id)).where(supervisor:staff_id)
        i = Internship.where(area:area_id).where(staff_id:staff_id)
      else
        s = Student.where(supervisor:staff_id)
        i = Internship.where(staff_id:staff_id)
      end
      if !student_name.blank?
        s = s.where("first_name LIKE '%#{student_name}%'").or(s.where("last_name LIKE '%#{student_name}%'"))
        i = i.where("first_name LIKE '%#{student_name}%'").or(i.where("last_name LIKE '%#{student_name}%'"))
      end
      student_ids = s.pluck(:id)
      internship_ids = i.pluck(:id)
    else
      if !student_name.blank?
        if !area_id.blank?
          student_ids = Student.where(supervisor:Staff.where(area_id:area_id).pluck(:id)).where("first_name LIKE '%#{student_name}%'").or(Student.where("last_name LIKE '%#{student_name}%'")).pluck(:id)
          internship_ids = Internship.where(area:area_id).where("first_name LIKE '%#{student_name}%'").or(Internship.where("last_name LIKE '%#{student_name}%'")).pluck(:id)
        else
          student_ids = Student.where("first_name LIKE '%#{student_name}%'").or(Student.where("last_name LIKE '%#{student_name}%'")).pluck(:id)
          internship_ids = Internship.where("first_name LIKE '%#{student_name}%'").or(Internship.where("last_name LIKE '%#{student_name}%'")).pluck(:id)
        end
      else
        if !area_id.blank?
          student_ids = Student.where(supervisor:Staff.where(area_id:area_id).pluck(:id)).pluck(:id)
          internship_ids = Internship.where(area:area_id).pluck(:id)
        end
      end
    end

    # filtro por área


    @scholarships = Scholarship.where.not(status: Scholarship::DELETED)
    # filtro por el tipo de beca
    @scholarships = @scholarships.where(scholarship_type_id:scholarship_type_id) if !scholarship_type_id.blank?
    # filtro por estatus
    @scholarships = @scholarships.where(status:status) unless status.blank?

    # filtro por el monto de la beca
    @scholarships = @scholarships.where(amount:amount) unless amount.blank?


    # filtro por el nombre de estudiante o por área
    if !student_name.blank? || !staff_id.blank? || !area_id.blank?
      @scholarships = @scholarships.where(person_type:'Student').where(person_id:student_ids).or(@scholarships.where(person_type:'Internship').where(person_id:internship_ids))
    end

    respond_to do |format|
      format.html do
        @scholarships = @scholarships.order('created_at desc').offset(scholarships_loaded).limit(50)
        render layout:false
      end
      ############################## Exportar a excel
      format.xls do
        rows = Array.new

        @scholarships.collect do |scholarship|
              rows << {
                  'Fecha de inicio'=> (scholarship.start_date rescue 'Sin información'),
                  'Fecha de término'=> (scholarship.end_date rescue 'Sin información'),
                  'Estado'=> (scholarship.get_status rescue 'Sin información'),
                  'Tipo de beca'=> (scholarship.scholarship_type.name rescue 'Sin información'),
                  'Id' => (scholarship.id rescue 'Sin información'),
                  'Monto' => (scholarship.amount rescue 'Sin información'),
                  'Estudiante' => (scholarship.person.full_name rescue 'Sin información'),
                  'Responsable'=> (scholarship.person_type == 'Student' ? scholarship.person.supervisor.full_name : scholarship.person.staff.full_name rescue 'Sin información'),
                  'Área'=> (scholarship.person_type == 'Student' ? scholarship.person.supervisor.area.name : scholarship.person.area.name rescue 'Sin información')
          }
        end
        column_order = ['Id','Tipo de beca','Estudiante','Área','Responsable','Fecha de inicio','Fecha de término','Monto mensual','Estado']
        to_excel(rows,column_order,"Servicios","Reporte_Becas")
      end
    end

  end

end


