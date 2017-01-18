require 'rails_helper'

RSpec.describe Api::React::ArticlesController, type: :controller do
  before :all do
    @user = FactoryGirl.create(:user)
    @session = FactoryGirl.create(:session, user: @user)
    @published_article = FactoryGirl.create(:article, author: @user, published_at: Time.current)
    @article2 = FactoryGirl.create(:article, author: @user)
    @article3 = FactoryGirl.create(:article, author: @user)
  end
  
  context 'user is signed in' do
    before :each do
      @request.headers['X-Access-Token'] = @session.access_token
    end
    
    describe 'GET #index' do
      before :each do
        get :index
      end
      
      it 'should have successful response status' do
        expect(response.status).to eq(200)
      end
      
      it 'should have valid content-type' do
        expect(response.content_type).to eq('application/json')
      end
      
      it 'should have proper order of articles' do
        responseBody = JSON.parse(response.body)
        article1 = responseBody[0]
        article2 = responseBody[1]
        article3 = responseBody[2]
        expect(article1['id']).to eq(@article3.id)
        expect(article2['id']).to eq(@article2.id)
        expect(article3['id']).to eq(@published_article.id)
      end
      
      context 'published article' do
        it 'should include article fields' do
          responseBody = JSON.parse(response.body)
          published_article = responseBody[2]
          expect(published_article['author']['full_name']).to eq(@published_article.author.full_name)
          expect(published_article['html_preview']).to eq(@published_article.html_preview)
          expect(published_article['id']).to eq(@published_article.id)
          expect(published_article['is_hidden']).to eq(@published_article.is_hidden)
          expect(published_article['position']).to eq(@published_article.position)
          expect(published_article['published_at']).to eq(@published_article.published_at.strftime('%B %d, %Y'))
          expect(published_article['title']).to eq(@published_article.title)
          expect(published_article['updated_at']).to eq(@published_article.updated_at.strftime('%B %d, %Y'))
        end
        
        it 'should NOT include article fields' do
          responseBody = JSON.parse(response.body)
          published_article = responseBody[2]
          expect(published_article['author_id']).to eq(nil)
          expect(published_article['content']).to eq(nil)
          expect(published_article['created_at']).to eq(nil)
          expect(published_article['html_content']).to eq(nil)
          expect(published_article['preview']).to eq(nil)
        end
      end
      
      context 'NOT published article' do
        it 'should include article fields' do
          responseBody = JSON.parse(response.body)
          article = responseBody[0]
          expect(article['author']['full_name']).to eq(@article3.author.full_name)
          expect(article['html_preview']).to eq(@article3.html_preview)
          expect(article['id']).to eq(@article3.id)
          expect(article['is_hidden']).to eq(@article3.is_hidden)
          expect(article['position']).to eq(@article3.position)
          expect(article['published_at']).to eq(nil)
          expect(article['title']).to eq(@article3.title)
          expect(article['updated_at']).to eq(@article3.updated_at.strftime('%B %d, %Y'))
        end
        
        it 'should NOT include article fields' do
          responseBody = JSON.parse(response.body)
          article = responseBody[0]
          expect(article['author_id']).to eq(nil)
          expect(article['content']).to eq(nil)
          expect(article['created_at']).to eq(nil)
          expect(article['html_content']).to eq(nil)
          expect(article['preview']).to eq(nil)
        end
      end
    end
    
    describe 'GET #show' do
      context 'article exists' do
        context 'article is published' do
          before :each do
            get :show, params: { id: @published_article.id }
          end
          
          it 'should have successful response status' do
            expect(response.status).to eq(200)
          end
          
          it 'should have valid content-type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should include article fields' do
            responseBody = JSON.parse(response.body)
            expect(responseBody['author']['full_name']).to eq(@published_article.author.full_name)
            expect(responseBody['content']).to eq(@published_article.content)
            expect(responseBody['html_content']).to eq(@published_article.html_content)
            expect(responseBody['html_preview']).to eq(@published_article.html_preview)
            expect(responseBody['id']).to eq(@published_article.id)
            expect(responseBody['is_hidden']).to eq(@published_article.is_hidden)
            expect(responseBody['preview']).to eq(@published_article.preview)
            expect(responseBody['published_at']).to eq(@published_article.published_at.strftime('%B %d, %Y'))
            expect(responseBody['title']).to eq(@published_article.title)
            expect(responseBody['updated_at']).to eq(@published_article.updated_at.strftime('%B %d, %Y'))
          end
          
          it 'should NOT include article fields' do
            responseBody = JSON.parse(response.body)
            expect(responseBody['author_id']).to eq(nil)
            expect(responseBody['created_at']).to eq(nil)
            expect(responseBody['position']).to eq(nil)
          end
        end
        
        context 'article is NOT published' do
          before :each do
            get :show, params: { id: @article2.id }
          end
          
          it 'should have successful response status' do
            expect(response.status).to eq(200)
          end
          
          it 'should have valid content-type' do
            expect(response.content_type).to eq('application/json')
          end
          
          it 'should include article fields' do
            responseBody = JSON.parse(response.body)
            expect(responseBody['author']['full_name']).to eq(@article2.author.full_name)
            expect(responseBody['content']).to eq(@article2.content)
            expect(responseBody['html_content']).to eq(@article2.html_content)
            expect(responseBody['html_preview']).to eq(@article2.html_preview)
            expect(responseBody['id']).to eq(@article2.id)
            expect(responseBody['is_hidden']).to eq(@article2.is_hidden)
            expect(responseBody['preview']).to eq(@article2.preview)
            expect(responseBody['published_at']).to eq(nil)
            expect(responseBody['title']).to eq(@article2.title)
            expect(responseBody['updated_at']).to eq(@article2.updated_at.strftime('%B %d, %Y'))
          end
          
          it 'should NOT include article fields' do
            responseBody = JSON.parse(response.body)
            expect(responseBody['author_id']).to eq(nil)
            expect(responseBody['created_at']).to eq(nil)
            expect(responseBody['position']).to eq(nil)
          end
        end
      end
      
      context 'article does NOT exist' do
        before :each do
          get :show, params: { id: @published_article.id + 30 }
        end
        
        it 'should have not found response status' do
          expect(response.status).to eq(404)
        end
        
        it 'should have valid content-type' do
          expect(response.content_type).to eq('application/json')
        end
        
        it 'should have empty JSON object as body' do
          expect(response.body).to eq('{}')
        end
      end
    end
  end
  
  context 'user is NOT signed in' do
  end
end
