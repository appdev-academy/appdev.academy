require 'rails_helper'

RSpec.describe Api::React::TestimonialsController, type: :controller do
  before :all do
    Testimonial.destroy_all
    @user = FactoryGirl.create(:user)
    @session = FactoryGirl.create(:session, user: @user)
    @published_testimonial = FactoryGirl.create(:testimonial, published: true)
    @unpublished_testimonial = FactoryGirl.create(:testimonial)
    FactoryGirl.create_list(:testimonial, 2)
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
      
      it 'should return proper count of Testimonials' do
        json_response = JSON.parse(response.body)
        expect(json_response['testimonials'].count).to eq(4)
      end
      
      it 'should include Testimonials fields' do
        json_response = JSON.parse(response.body)
        json_response['testimonials'].each do |testimonial_json|
          includes_fields_for_testimonial_index(testimonial_json)
        end
      end
      
      it 'should NOT include Testimonials fields' do
        json_response = JSON.parse(response.body)
        json_response['testimonials'].each do |testimonial_json|
          not_includes_fields_for_testimonial_index(testimonial_json)
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
          get :show, params: { id: @published_testimonial.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should include Testimonials fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_testimonial(json_response['testimonial'])
        end
        
        it 'should NOT include Testimonials fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_testimonial(json_response['testimonial'])
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          get :show, params: { id: @published_testimonial.id + 100 }
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
          get :show, params: { id: @published_testimonial.id }
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
          get :show, params: { id: @published_testimonial.id }
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
          testimonial_params = FactoryGirl.attributes_for(:testimonial)
          @testimonial_count = Testimonial.count
          post :create, params: { testimonial: testimonial_params }
        end
        
        it 'should have :created (201) HTTP response status' do
          expect(response).to have_http_status(201)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should create Testimonial' do
          expect(@testimonial_count).not_to eq(Testimonial.count)
        end
        
        it 'should include Testimonials fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_testimonial(json_response['testimonial'])
        end
        
        it 'should NOT include Testimonials fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_testimonial(json_response['testimonial'])
        end
      end
      
      context 'with INVALID params' do
        context 'WITHOUT body params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, body: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Body can't be blank")
          end
        end
        
        context 'WITHOUT company params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, company: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Company can't be blank")
          end
        end
        
        context 'WITHOUT first_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, first_name: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("First name can't be blank")
          end
        end
        
        context 'WITHOUT html_body params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, html_body: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Html body can't be blank")
          end
        end
        
        context 'WITHOUT last_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, last_name: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
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
            testimonial_params = FactoryGirl.attributes_for(:testimonial, profile_picture: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
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
            testimonial_params = FactoryGirl.attributes_for(:testimonial, title: nil)
            @testimonial_count = Testimonial.count
            post :create, params: { testimonial: testimonial_params }
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT create Testimonial' do
            expect(@testimonial_count).to eq(Testimonial.count)
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
          testimonial_params = FactoryGirl.attributes_for(:testimonial)
          post :create, params: { testimonial: testimonial_params }
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
          testimonial_params = FactoryGirl.attributes_for(:testimonial)
          post :create, params: { testimonial: testimonial_params }
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
          testimonial_params = FactoryGirl.attributes_for(:testimonial)
          patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
          @updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should update Testimonial' do
          expect(@updated_testimonial).not_to equal(@published_testimonial)
        end
        
        it 'should include Testimonials fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_testimonial(json_response['testimonial'])
        end
        
        it 'should NOT include Testimonials fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_testimonial(json_response['testimonial'])
        end
      end
      
      context 'with INVALID params' do
        context 'with NOT existing Testimonial' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial)
            patch :update, params: { id: @published_testimonial.id + 100, testimonial: testimonial_params }
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
        
        context 'WITHOUT body params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, body: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Body can't be blank")
          end
        end
        
        context 'WITHOUT company params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, company: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Company can't be blank")
          end
        end
        
        context 'WITHOUT first_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, first_name: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("First name can't be blank")
          end
        end
        
        context 'WITHOUT html_body params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, html_body: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
          end
          
          it 'should include errors' do
            json_response = JSON.parse(response.body)
            expect(json_response.key?('errors')).to eq(true)
            expect(json_response['errors'].first).to eq("Html body can't be blank")
          end
        end
        
        context 'WITHOUT last_name params' do
          before :each do
            request.headers['X-Access-Token'] = @session.access_token
            testimonial_params = FactoryGirl.attributes_for(:testimonial, last_name: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
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
            testimonial_params = FactoryGirl.attributes_for(:testimonial, profile_picture: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
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
            testimonial_params = FactoryGirl.attributes_for(:testimonial, title: nil)
            patch :update, params: { id: @published_testimonial.id, testimonial: testimonial_params }
            @not_updated_testimonial = Testimonial.find_by(id: @published_testimonial.id)
          end
          
          it 'should have :unprocessable_entity (422) HTTP response status' do
            expect(response).to have_http_status(422)
          end
          
          it 'should have right content type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should NOT update Testimonial' do
            expect(@not_updated_testimonial).to eq(@published_testimonial)
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
          patch :update, params: { id: @published_testimonial.id }
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
          patch :update, params: { id: @published_testimonial.id }
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
        @destroy_testimonial = FactoryGirl.create(:testimonial)
      end
      
      context 'with valid params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          delete :destroy, params: { id: @destroy_testimonial.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should delete Testimonial' do
          expect(Testimonial.find_by(id: @destroy_testimonial.id)).to eq(nil)
        end
        
        it 'should have success' do
          json_response = JSON.parse(response.body)
          expect(json_response['success']).to eq(true)
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          delete :destroy, params: { id: @destroy_testimonial.id + 100 }
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
        @destroy_testimonial = FactoryGirl.create(:testimonial)
      end
      
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          delete :destroy, params: { id: @destroy_testimonial.id }
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
          delete :destroy, params: { id: @destroy_testimonial.id }
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
          post :publish, params: { id: @unpublished_testimonial.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should publish Testimonial' do
          expect(@unpublished_testimonial.reload.published).to eq(true)
        end
        
        it 'should include Testimonials fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_testimonial(json_response['testimonial'])
        end
        
        it 'should NOT include Testimonials fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_testimonial(json_response['testimonial'])
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          post :publish, params: { id: @unpublished_testimonial.id + 100 }
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
          post :publish, params: { id: @unpublished_testimonial.id }
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
          post :publish, params: { id: @unpublished_testimonial.id }
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
          pub = FactoryGirl.create(:testimonial, published: true)
          post :hide, params: { id: @published_testimonial.reload.id }
        end
        
        it 'should have :ok (200) HTTP response status' do
          expect(response).to have_http_status(200)
        end
        
        it 'should have right content type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should unpublish Testimonial' do
          expect(@published_testimonial.reload.published).to eq(false)
        end
        
        it 'should include Testimonials fields' do
          json_response = JSON.parse(response.body)
          includes_fields_for_testimonial(json_response['testimonial'])
        end
        
        it 'should NOT include Testimonials fields' do
          json_response = JSON.parse(response.body)
          not_includes_fields_for_testimonial(json_response['testimonial'])
        end
      end
      
      context 'with INVALID params' do
        before :each do
          request.headers['X-Access-Token'] = @session.access_token
          post :hide, params: { id: @published_testimonial.id + 100 }
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
          post :hide, params: { id: @published_testimonial.id }
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
          post :hide, params: { id: @published_testimonial.id }
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
          post :sort, params: { testimonial_ids: [@published_testimonial, @unpublished_testimonial] }
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
        
        it 'should update position to Testimonials' do
          expect(@unpublished_testimonial.reload.position).to eq(1)
          expect(@published_testimonial.reload.position).to eq(2)
        end
      end
    end
    
    context 'User is NOT authorized' do
      context 'INVALID Access token' do
        before :each do
          request.headers['X-Access-Token'] = SecureRandom.hex(16) + 'invalid'
          post :sort, params: { testimonial_ids: [@published_testimonial, @unpublished_testimonial] }
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
          post :sort, params: { testimonial_ids: [@published_testimonial, @unpublished_testimonial] }
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
