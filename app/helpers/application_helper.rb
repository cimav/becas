module ApplicationHelper

  def f_date_no_time(date)
    I18n.l(date, format: '%d de %B %Y').capitalize
  end


  def f_date(date)
    if "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day}"
      r_date = "Hoy"
      r_date = r_date + " a las " + date.strftime("%l:%M %P") if (date.hour != nil)
    elsif "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day - 1}"
      r_date = "Ayer"
      r_date = r_date + " a las " + date.strftime("%l:%M %P") if (date.hour != nil)
    elsif "#{date.year}#{date.month}#{date.day}" == "#{Time.now.year}#{Time.now.month}#{Time.now.day + 1}"
      r_date = "Mañana"
      r_date = r_date + " a las " + date.strftime("%l:%M %P") if (date.hour != nil)
    else
      r_date = I18n.l(date, format: '%d de %B %Y a las %l:%M %P').capitalize
      # d = "#{date.year}#{date.month}#{date.day}".to_i
      # t = "#{Time.now.year}#{Time.now.month}#{Time.now.day}".to_i
      # if d > t
      #   r_date = "En #{t - d} días"
      # else
      #   r_date = "Hace #{d - t} días"
      # end
    end
  end

  def active_class(link_path)
    "active" if request.path.start_with?(link_path)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_staff
    @current_staff ||= Staff.find(session[:user_id]) if session[:user_id]
  end


  def is_admin?
    if (user = current_user if session[:user_type].eql? 'User')
      user.user_type == User::ADMIN || current_user.user_type == User::SUPER_USER
    end
  end


  def print_document(to, content,file_name)
    pdf = Prawn::Document.new(background: "private/membretada2018.png", background_scale: 0.36, right_margin: 20)
    y= 620
    pdf.font_size 12
    # Cabecera
    text = "Coordinación de Estudios de Posgrado
         <b>FOLIO---</b>
          Chihuahua, Chih., a #{I18n.l(Date.today, format: '%d de %B del %Y')}"
    pdf.text_box text,size:11, at:[320,y], align: :right, inline_format:true

    # Destinatario
    text = to
    pdf.text_box text, at:[20,y-=60]
    # Presente
    pdf.text_box"<b>P r e s e n t e.-</b>", :size => 12, at:[20,y-=48], inline_format:true
    # contenido
    text = content + "\n\n Sin más por el momento reciba un cordial saludo.."
    pdf.text_box text, at:[20,y-=50], inline_format:true
    # atentamente
    text = "Atentamente,"
    pdf.text_box text, at:[0,150], align: :center
    # firma
    text = "<b>Lic. Emilio Pascual Domínguez Lechuga \n Coordinador de Estudios de Posgrado</b>"
    pdf.text_box text, at:[0,80], align: :center, inline_format:true

    send_data pdf.render, filename: "#{file_name}.pdf", type: 'application/pdf', disposition: 'inline'
  end


end
