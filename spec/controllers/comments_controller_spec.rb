require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST create" do
    login_user # login user before validations

    context "with valid attributes" do
      let!(:movie) { create(:movie) }
      it 'creates a new comment with valid attributes' do
        expect{
          post :create, params: {:movie_id => movie.id, :comment => attributes_for(:comment)}
        }.to change(Comment,:count).by(1)
      end

      it "redirects to the movie page" do
        post :create, params: {:movie_id => movie.id, :comment => attributes_for(:comment)}
        response.should redirect_to movie_path(movie)
      end
    end

    context "with invalid attributes" do
      let!(:movie) { create(:movie) }
      it "does not save the new comment" do
        expect{
          post :create, params: {:movie_id => movie.id, :comment => attributes_for(:invalid_comment)}
        }.to_not change(Comment,:count)
      end

      it "redirects to the movie page" do
        post :create, params: {:movie_id => movie.id, :comment => attributes_for(:invalid_comment)}
        response.should redirect_to movie_path(movie)
      end
    end

    context "with already created comment" do
      let!(:comment) { create(:comment) }
      let!(:movie) { create(:movie) }
      it "does not save the new comment" do
        post :create, params: {:movie_id => movie.id, :comment => comment.attributes}
        expect{
          post :create, params: {:movie_id => movie.id, :comment => comment.attributes}
        }.to_not change(Comment,:count)
      end

      it "redirects to the movie page" do
        post :create, params: {:movie_id => movie.id, :comment => attributes_for(:comment)}
        response.should redirect_to movie_path(movie)
      end
    end
  end

  describe '#DELETE destroy' do
    let!(:comment) { create(:comment) }
    let!(:movie) { create(:movie) }
    it 'deletes a comment' do
      movie.comments << comment
      expect{delete :destroy, params: { :id => comment.id, movie_id: movie.id}
      }.to change(Comment,:count).by(-1)
      expect(response).to redirect_to movie_path(movie)
    end
  end

end
