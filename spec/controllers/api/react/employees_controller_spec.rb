require 'rails_helper'

RSpec.describe Api::React::EmployeesController, type: :controller do
  before :all do
    Employee.destroy_all
    @user = FactoryBot.create(:user)
    @session = FactoryBot.create(:session, user: @user)
    @published_employee = FactoryBot.create(:employee, published: true)
    @unpublished_employee = FactoryBot.create(:employee)
    FactoryBot.create_list(:employee, 2)
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
          includes_fields_for_employee(employee_json)
        end
      end
      
      it 'should NOT include Employees fields' do
        json_response = JSON.parse(response.body)
        json_response['employees'].each do |employee_json|
          not_includes_fields_for_employee(employee_json)
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
        
        it 'should have :not_found (404) HTTP response status' do
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
  
  describe 'POST #create' do
    context 'User is authorized' do
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          employee_params = FactoryBot.attributes_for(:employee)
          @employee_count = Employee.count
          post :create, params: { employee: employee_params }
        end
        
        it 'should have :created (201) HTTP response status' do
          expect(response).to have_http_status(201)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should create Employee' do
          expect(@employee_count).not_to eq(Employee.count)
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
        context 'WITHOUT first_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, first_name: nil)
            @employee_count = Employee.count
            post :create, params: { employee: employee_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Employee' do
            expect(@employee_count).to eq(Employee.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("First name can't be blank")
          end
        end
        
        context 'WITHOUT last_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, last_name: nil)
            @employee_count = Employee.count
            post :create, params: { employee: employee_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Employee' do
            expect(@employee_count).to eq(Employee.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Last name can't be blank")
          end
        end
        
        context 'WITHOUT profile_picture params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, profile_picture: nil)
            @employee_count = Employee.count
            post :create, params: { employee: employee_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Employee' do
            expect(@employee_count).to eq(Employee.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Profile picture can't be blank")
          end
        end
        
        context 'WITHOUT title params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, title: nil)
            @employee_count = Employee.count
            post :create, params: { employee: employee_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Employee' do
            expect(@employee_count).to eq(Employee.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Title can't be blank")
          end
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          employee_params = FactoryBot.attributes_for(:employee)
          post :create, params: { employee: employee_params }
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
          employee_params = FactoryBot.attributes_for(:employee)
          post :create, params: { employee: employee_params }
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
          patch :update, params: { id: @published_employee.id, employee: employee_params }
          @updated_employee = Employee.find_by(id: @published_employee.id)
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should update Employee' do
          expect(@updated_employee).not_to equal(@published_employee)
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
        context 'with NOT existing Employee' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee)
            patch :update, params: { id: @published_employee.id + 100, employee: employee_params }
          end
          
          it 'should have :not_found (404) HTTP response status' do
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
        
        context 'WITHOUT first_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, first_name: nil)
            patch :update, params: { id: @published_employee.id, employee: employee_params }
            @not_updated_employee = Employee.find_by(id: @published_employee.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Employee' do
            expect(@not_updated_employee).to eq(@published_employee)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("First name can't be blank")
          end
        end
        
        context 'WITHOUT last_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, last_name: nil)
            patch :update, params: { id: @published_employee.id, employee: employee_params }
            @not_updated_employee = Employee.find_by(id: @published_employee.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Employee' do
            expect(@not_updated_employee).to eq(@published_employee)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Last name can't be blank")
          end
        end
        
        context 'WITHOUT profile_picture params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, profile_picture: nil)
            patch :update, params: { id: @published_employee.id, employee: employee_params }
            @not_updated_employee = Employee.find_by(id: @published_employee.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Employee' do
            expect(@not_updated_employee).to eq(@published_employee)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Profile picture can't be blank")
          end
        end
        
        context 'WITHOUT title params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            employee_params = FactoryBot.attributes_for(:employee, title: nil)
            patch :update, params: { id: @published_employee.id, employee: employee_params }
            @not_updated_employee = Employee.find_by(id: @published_employee.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Employee' do
            expect(@not_updated_employee).to eq(@published_employee)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Title can't be blank")
          end
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          patch :update, params: { id: @published_employee.id }
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
          patch :update, params: { id: @published_employee.id }
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
  
  describe 'DELETE #destroy' do
    context 'User is authorized' do
      before :context do
        @destroy_employee = FactoryBot.create(:employee)
      end
      
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          delete :destroy, params: { id: @destroy_employee.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should delete Employee' do
          expect(Employee.find_by(id: @destroy_employee.id)).to eq(nil)
        end
        
        it 'should have success' do
          json_response = JSON.parse(response.body)
          expect(json_response['success']).to eq(true)
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          delete :destroy, params: { id: @destroy_employee.id + 100 }
        end
        
        it 'should have :not_found (404) HTTP response status' do
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
      before :context do
        @destroy_employee = FactoryBot.create(:employee)
      end
      
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          delete :destroy, params: { id: @destroy_employee.id }
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
          delete :destroy, params: { id: @destroy_employee.id }
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
  
  describe 'POST #publish' do
    context 'User is authorized' do
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          post :publish, params: { id: @unpublished_employee.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should publish Employee' do
          expect(@unpublished_employee.reload.published).to eq(true)
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
          post :publish, params: { id: @unpublished_employee.id + 100 }
        end
        
        it 'should have :not_found (404) HTTP response status' do
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
          post :publish, params: { id: @unpublished_employee.id }
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
          post :publish, params: { id: @unpublished_employee.id }
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
  
  describe 'POST #hide' do
    context 'User is authorized' do
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          pub = FactoryBot.create(:employee, published: true)
          post :hide, params: { id: @published_employee.reload.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should unpublish Employee' do
          expect(@published_employee.reload.published).to eq(false)
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
          post :hide, params: { id: @published_employee.id + 100 }
        end
        
        it 'should have :not_found (404) HTTP response status' do
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
          post :hide, params: { id: @published_employee.id }
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
          post :hide, params: { id: @published_employee.id }
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
  
  describe 'POST #sort' do
    context 'User is authorized' do
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          post :sort, params: { employee_ids: [@published_employee, @unpublished_employee] }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should have success' do
          json_response = JSON.parse(response.body)
          expect(json_response['success']).to eq(true)
        end
        
        it 'should update position to Employees' do
          expect(@unpublished_employee.reload.position).to eq(1)
          expect(@published_employee.reload.position).to eq(2)
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          post :sort, params: { employee_ids: [@published_employee, @unpublished_employee] }
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
          post :sort, params: { employee_ids: [@published_employee, @unpublished_employee] }
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
