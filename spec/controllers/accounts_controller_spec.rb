require 'spec_helper'

describe AccountsController do

  {
      show: "get",
      edit: "get",
      update: "put",
      destroy: "delete"
  }.each do |action, method|
    describe "#{method.upcase} '#{action}'" do
      context "not signed in" do
        before(:each) do
          send(method, action, {})
        end

        it { expect(response).to redirect_to new_user_session_path }
      end
    end
  end

  context "signed in" do
    let(:user) { create :user, password: "testpassword" }
    before(:each) { sign_in user }

    describe "GET 'show'" do
      before(:each) do
        sign_in user
        get :show
      end

      it { expect(assigns(:user)).to eq(user) }
      it { expect(response).to be_success }
    end

    describe "GET 'edit'" do
      before(:each) do
        get :edit
      end

      it { expect(assigns(:user)).to eq(user) }
      it { expect(response).to be_success }
    end

    describe "PUT 'update'" do
      context "with valid params" do
        before(:each) do
          put :update, { user: { email: "new@email.com", current_password: "testpassword" } }
        end

        it { expect(assigns(:user)).to eq(user) }
        it { expect(response).to redirect_to edit_account_path }
      end

      context "with invalid params" do
        before(:each) do
          put :update, { user: { email: "" } }
        end

        it { expect(response).to render_template 'edit' }
      end
    end

    describe "DELETE 'destroy'" do
      context do
        before(:each) do
          delete :destroy
        end

        it { expect(assigns(:user)).to eq(user) }
        it { expect(response).to redirect_to root_path }
      end

      context "deletes user" do
        it { expect { delete :destroy }.to change(User, :count).by(-1) }
      end
    end
  end
end
