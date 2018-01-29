module FieldsValidationHelper
  def includes_fields_for_employee(employee_json)
    expect(employee_json.key?('first_name')).to eq(true)
    expect(employee_json.key?('id')).to eq(true)
    expect(employee_json.key?('last_name')).to eq(true)
    expect(employee_json.key?('position')).to eq(true)
    expect(employee_json.key?('profile_picture')).to eq(true)
    expect(employee_json.key?('published')).to eq(true)
    expect(employee_json.key?('title')).to eq(true)
    expect(employee_json.key?('updated_at')).to eq(true)
  end
  
  def not_includes_fields_for_employee(employee_json)
    expect(employee_json.key?('created_at')).to eq(false)
  end
  
  def includes_fields_for_testimonial(testimonial_json)
    expect(testimonial_json.key?('body')).to eq(true)
    expect(testimonial_json.key?('company')).to eq(true)
    expect(testimonial_json.key?('first_name')).to eq(true)
    expect(testimonial_json.key?('html_body')).to eq(true)
    expect(testimonial_json.key?('id')).to eq(true)
    expect(testimonial_json.key?('last_name')).to eq(true)
    expect(testimonial_json.key?('position')).to eq(true)
    expect(testimonial_json.key?('profile_picture')).to eq(true)
    expect(testimonial_json.key?('published')).to eq(true)
    expect(testimonial_json.key?('title')).to eq(true)
    expect(testimonial_json.key?('updated_at')).to eq(true)
  end
  
  def not_includes_fields_for_testimonial(testimonial_json)
    expect(testimonial_json.key?('created_at')).to eq(false)
  end
  
  def includes_fields_for_testimonial_index(testimonial_json)
    expect(testimonial_json.key?('company')).to eq(true)
    expect(testimonial_json.key?('first_name')).to eq(true)
    expect(testimonial_json.key?('id')).to eq(true)
    expect(testimonial_json.key?('last_name')).to eq(true)
    expect(testimonial_json.key?('position')).to eq(true)
    expect(testimonial_json.key?('profile_picture')).to eq(true)
    expect(testimonial_json.key?('published')).to eq(true)
    expect(testimonial_json.key?('title')).to eq(true)
  end
  
  def not_includes_fields_for_testimonial_index(testimonial_json)
    expect(testimonial_json.key?('body')).to eq(false)
    expect(testimonial_json.key?('created_at')).to eq(false)
    expect(testimonial_json.key?('html_body')).to eq(false)
    expect(testimonial_json.key?('updated_at')).to eq(false)
  end
end
