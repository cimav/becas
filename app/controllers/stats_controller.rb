class StatsController < ApplicationController

  def index
    @scholarship_types_values = []
    @department_fiscal_expense_values = []
    @department_own_expense_values = []
    @scholarhips_approved_by_month = []
    @scholarhips_rejected_by_month = []

    @scholarship_types_titles = []
    @department_fiscal_expense_titles = []
    @department_own_expense_titles = []

    @scholarships = Scholarship.where.not(status:[Scholarship::DELETED, Scholarship::REQUESTED, Scholarship::REJECTED])

    # Obtener número de tipos de beca
    @scholarships.group(:scholarship_type).count.each_with_index  do |scholarship_type, index|
      @scholarship_types_titles[index] = "#{scholarship_type[0].name}: #{scholarship_type[1]}"
      @scholarship_types_values[index] = scholarship_type[1]
    end

    #obtener egresos fiscales por departamento
    department_expense_hash = Hash.new(0)
    @scholarships.where(scholarship_type:ScholarshipType.where(category:ScholarshipType::FISCAL)).each do |scholarship|
      if scholarship.person_type == 'Student'
        department_expense_hash[scholarship.person.supervisor.area.name] += scholarship.amount
      elsif scholarship.person_type == 'Internship'
        department_expense_hash[scholarship.person.area.name] += scholarship.amount
      end
    end

    department_expense_hash.each_with_index do |department_expense, index|
      @department_fiscal_expense_titles[index] = department_expense[0]
      @department_fiscal_expense_values[index] = department_expense[1]
    end

    #obtener egresos propios por departamento
    department_expense_hash = Hash.new(0)
    @scholarships.where(scholarship_type:ScholarshipType.where(category:ScholarshipType::OWN_RESOURCES)).each do |scholarship|
      if scholarship.person_type == 'Student'
        department_expense_hash[scholarship.person.supervisor.area.name] += scholarship.amount
      elsif scholarship.person_type == 'Internship'
        department_expense_hash[scholarship.person.area.name] += scholarship.amount
      end
    end

    department_expense_hash.each_with_index do |department_expense, index|
      @department_own_expense_titles[index] = department_expense[0]
      @department_own_expense_values[index] = department_expense[1]
    end


    #obtener número de becas al año
    for month in 1..12
      @scholarhips_approved_by_month[month -1] = @scholarships.where('extract(month from start_date) = ?', month).size
      @scholarhips_rejected_by_month[month -1] = Scholarship.where('extract(month from start_date) = ?', month).where(status:Scholarship::REJECTED).size
    end
  end
end
