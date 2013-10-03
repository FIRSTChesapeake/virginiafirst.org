require 'spec_helper'

describe Admin::Volunteer::RolesController do
  let!(:role) { create :volunteer_role }

  {
      index: "get",
      show: "get",
      new: "get",
      create: "post",
      edit: "get",
      update: "put",
      destroy: "delete"
  }.each do |action, method|
    describe "#{method.upcase} '#{action}'" do
      context "not signed in" do
        before(:each) do
          send(method, action, { id: 0 })
        end

        it { expect(response).to redirect_to new_user_session_path }
      end
    end
  end

  context "signed in" do
    let(:user) { create :admin }
    before(:each) { sign_in user }

    describe "GET 'index'" do
      before(:each) { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:roles)).to eq [role] }
    end

    describe "GET 'show'" do
      before(:each) { get :show, { id: role.to_param } }

      it { expect(response).to be_success }
      it { expect(assigns(:role)).to eq role }
    end

    describe "GET 'new'" do
      before(:each) { get :new }

      it { expect(response).to be_success }
      it { expect(assigns(:role)).to be_a_new Volunteer::Role }
    end

    describe "POST 'create'" do
      context "with valid parameters" do
        let(:valid_attributes) { attributes_for :volunteer_role }

        describe "persistence" do
          it "saves role to database" do
            expect {
              post :create, { volunteer_role: valid_attributes }
            }.to change(Volunteer::Role, :count).by(1)
          end
        end

        describe "response" do
          before(:each) { post :create, { volunteer_role: valid_attributes } }

          it { expect(response).to redirect_to admin_volunteer_roles_path }
          it { expect(assigns(:role)).to be_an_instance_of Volunteer::Role }
          it { expect(assigns(:role).title).to eq valid_attributes[:title] }
          it { expect(assigns(:role)).not_to be_new_record }
          it { expect(flash[:notice]).to eq "Role successfully created." }
        end
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { attributes_for :volunteer_role, title: "" }

        describe "persistence" do
          it "fails to save role to database" do
            expect {
              post :create, { volunteer_role: invalid_attributes }
            }.to change(Volunteer::Role, :count).by(0)
          end

          describe "response" do
            before(:each) { post :create, { volunteer_role: invalid_attributes } }

            it { expect(response).to render_template :new }
            it { expect(assigns(:role)).to be_new_record }
          end
        end
      end
    end

    describe "GET 'edit'" do
      before(:each) { get :edit, { id: role.to_param } }

      it { expect(response).to be_success }
      it { expect(assigns(:role)).to eq role }
    end

    describe "PUT 'update'" do
      context "with valid parameters" do
        let(:valid_attributes) { { title: :new_role } }
        before(:each) { put :update, { id: role.to_param, volunteer_role: valid_attributes } }

        it { expect(response).to redirect_to admin_volunteer_roles_path }
        it { expect(assigns(:role)).to eq role }
        it { expect(assigns(:role).title).to eq "new_role" }
        it { expect(assigns(:role).changed?).to be_false }
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { { title: "" } }
        before(:each) { put :update, { id: role.to_param, volunteer_role: invalid_attributes } }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:role).title).to eq "" }
        it { expect(assigns(:role).changed?).to be_true }
      end
    end

    describe "DELETE 'destroy'" do
      describe "persistence" do
        it "removes role from database" do
          expect {
            delete :destroy, { id: role.to_param }
          }.to change(Volunteer::Role, :count).by(-1)
        end
      end

      describe "response behavior" do
        before(:each) { delete :destroy, { id: role.to_param } }

        it { expect(response).to redirect_to admin_volunteer_roles_path }
        it { expect(assigns(:role)).to eq role }
      end
    end
  end
end
