require 'rails_helper'

RSpec.describe Api::React::EmployeesController, type: :controller do
  before :all do
    Employee.destroy_all
    @user = FactoryGirl.create(:user)
    @session = FactoryGirl.create(:session, user: @user)
    @published_employee = FactoryGirl.create(:employee, published: true)
    FactoryGirl.create_list(:employee, 3)
  end
  
  describe 'GET #index' do
    context 'User is authorized' do
      before :each do
        request.headers['X-Access-Token'] = @session.access_token
        get :index
      end
      
      it 'should have :ok (200) HTTP response status' do
        expect(response).to have_http_status(200)
      end
      
      it 'should have right content type' do
        expect(response.content_type).to eq('application/json')
      end
      
      it 'should return proper count of Employees' do
        json_response = JSON.parse(response.body)
        expect(json_response['employees'].count).to eq(4)
      end
      
      it 'should include Employees fields' do
        json_response = JSON.parse(response.body)
        json_response['employees'].each do |employee_json|
          includes_fields_for_employees(employee_json)
        end
      end
      
      it 'should NOT include Employees fields' do
        json_response = JSON.parse(response.body)
        json_response['employees'].each do |employee_json|
          not_includes_fields_for_employees(employee_json)
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          get :index
        end
        
        it 'should have :unauthorized (401) HTTP response status' do
          expect(response).to have_http_status(401)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should render right error message' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors'].last).to eq('Session with this access token not found')
        end
      end
      
      context 'WITHOUT Access token' do
        before :each do
          get :index
        end
        
        it 'should have :unauthorized (401) HTTP response status' do
          expect(response).to have_http_status(401)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should render right error message' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors'].last).to eq('No access token')
        end
      end
    end
  end
  
  describe 'GET #show' do
    context 'User is authorized' do
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          get :show, params: { id: @published_employee.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should include Employees fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_employee(json_response['employee'])
        end
        
        it 'should NOT include Employees fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_employee(json_response['employee'])
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          get :show, params: { id: @published_employee.id + 100 }
        end
        
        it 'should have :unprocessable_entity (404) HTTP response status' do
          expect(response).to have_http_status(404)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should have empty JSON object as body' do
          json_response = JSON.parse(response.body)
          expect(json_response).to be_empty
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          get :show, params: { id: @published_employee.id }
        end
        
        it 'should have :unauthorized (401) HTTP response status' do
          expect(response).to have_http_status(401)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should render right error message' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors'].last).to eq('Session with this access token not found')
        end
      end
      
      context 'WITHOUT Access token' do
        before :each do
          get :show, params: { id: @published_employee.id }
        end
        
        it 'should have :unauthorized (401) HTTP response status' do
          expect(response).to have_http_status(401)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should render right error message' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors'].last).to eq('No access token')
        end
      end
    end
  end
  
  describe 'PATCH #update' do
    context 'User is authorized' do
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          employee_params = FactoryBot.attributes_for(:employee)
          get :show, params: { id: @published_employee.id, employee: employee_params }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should include Employees fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_employee(json_response['employee'])
        end
        
        it 'should NOT include Employees fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_employee(json_response['employee'])
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          get :show, params: { id: @published_employee.id + 100 }
        end
        
        it 'should have :unprocessable_entity (404) HTTP response status' do
          expect(response).to have_http_status(404)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should have empty JSON object as body' do
          json_response = JSON.parse(response.body)
          expect(json_response).to be_empty
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          get :show, params: { id: @published_employee.id }
        end
        
        it 'should have :unauthorized (401) HTTP response status' do
          expect(response).to have_http_status(401)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should render right error message' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors'].last).to eq('Session with this access token not found')
        end
      end
      
      context 'WITHOUT Access token' do
        before :each do
          get :show, params: { id: @published_employee.id }
        end
        
        it 'should have :unauthorized (401) HTTP response status' do
          expect(response).to have_http_status(401)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should render right error message' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors'].last).to eq('No access token')
        end
      end
    end
  end
end
