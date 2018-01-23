class Api::React::EmployeesController < Api::React::ApiController
  before_action :set_employee, only: [:show, :update, :destroy, :publish, :hide]
  
  # GET api/react/employees
  def index
    employees = Employee.order('position DESC').limit(100)
    employees_json = ActiveModel::Serializer::CollectionSerializer.new(employees, serializer: EmployeeIndexSerializer).as_json
    render json: { employees: employees_json }, status: :ok
  end
  
  # GET api/react/employees/:id
  def show
    employee_json = EmployeeShowSerializer.new(@employee).as_json
    render json: { employee: employee_json }, status: :ok
  end
  
  # POST api/react/employees
  def create
    employee = Employee.new(employee_params)
    
    if employee.save
      employee_json = EmployeeShowSerializer.new(employee).as_json
      render json: { employee: employee_json }, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # PUT/PATCH api/react/employees/:id
  def update
    if @employee.update(employee_params)
      employee_json = EmployeeShowSerializer.new(@employee).as_json
      render json: { employee: employee_json }, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # DELETE api/react/employees/:id
  def destroy
    @employee.destroy
    render json: { success: true }, status: :ok
  end
  
  # POST api/react/employees/:id/publish
  def publish
    if @employee.update(published: true)
      employee_json = EmployeeShowSerializer.new(@employee).as_json
      render json: { employee: employee_json }, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # POST api/react/employees/:id/hide
  def hide
    if @employee.update(published: false)
      employee_json = EmployeeShowSerializer.new(@employee).as_json
      render json: { employee: employee_json }, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # POST api/react/employees/sort
  def sort
    params[:employee_ids].reverse.each_with_index do |id, index|
      Employee.where(id: id).update_all(position: index + 1)
    end
    render json: { success: true }, status: :ok
  end
  
  private
    def set_employee
      @employee = Employee.find(params[:id])
    end
    
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :profile_picture, :title)
    end
end
