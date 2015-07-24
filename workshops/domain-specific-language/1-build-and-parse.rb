class Company

  TooManyManagingDirectorsError = Class.new(Exception)

  attr_reader :departments

  def initialize(&block)
    @departments = []

    instance_eval(&block)
  end

  def department(name, &block)
    departments << Department.new(self, name, &block)
  end

  def employees
    departments.map do |department|
      department.employees
    end.flatten
  end

  def managing_director
    employees.select { |e| e.managing_director? }.first
  end

  class Department
    attr_reader :company,
                :name,
                :employees

    def initialize(company, name, &block)
      @company = company
      @name = name
      @employees = []

      instance_eval(&block)
    end

    def employee(&block)
      @employees << Employee.new(self, &block)
    end

  end

  class Employee

    def initialize(department, &block)
      @department = department
      instance_eval(&block)
    end

    def managing_director
      if @department.company.managing_director.nil?
        @managing_director = true
      else
        raise TooManyManagingDirectorsError, 'Only allow one MD.'
      end
    end

    # The !! coerces the return type to a boolean value
    def managing_director?
      !!@managing_director
    end


    %w( first_name last_name role ).each do |method|
      define_method method do |*args|
        attribute = "@#{method}"
        if args.empty?
          self.instance_variable_get(attribute)
        else
          self.instance_variable_set(attribute, args.first)
        end
      end
    end
  end

end

def company(&block)
  if block_given?
    @company = Company.new(&block)
  else
    @company
  end
end

require_relative 'run'
