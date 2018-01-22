module FieldsValidationHelper
  def includes_fields_for_employees(employee_json)
    expect(employee_json.key?('first_name')).to eq(true)
    expect(employee_json.key?('last_name')).to eq(true)
    expect(employee_json.key?('profile_picture')).to eq(true)
    expect(employee_json.key?('position')).to eq(true)
    expect(employee_json.key?('published')).to eq(true)
    expect(employee_json.key?('title')).to eq(true)
  end
  
  def not_includes_fields_for_employees(employee_json)
    expect(employee_json.key?('created_at')).to eq(false)
    expect(employee_json.key?('id')).to eq(false)
    expect(employee_json.key?('updated_at')).to eq(false)
  end
  
  def includes_fields_for_employee(employee_json)
    expect(employee_json.key?('first_name')).to eq(true)
    expect(employee_json.key?('id')).to eq(true)
    expect(employee_json.key?('last_name')).to eq(true)
    expect(employee_json.key?('profile_picture')).to eq(true)
    expect(employee_json.key?('position')).to eq(true)
    expect(employee_json.key?('published')).to eq(true)
    expect(employee_json.key?('title')).to eq(true)
    expect(employee_json.key?('updated_at')).to eq(true)
  end
  
  def not_includes_fields_for_employee(employee_json)
    expect(employee_json.key?('created_at')).to eq(false)
  end
end
