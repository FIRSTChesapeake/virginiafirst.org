require 'spec_helper'

describe Admin::SkillsController do

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
    let!(:skill) { create :skill }
    before(:each) { sign_in user }

    describe "GET 'index'" do
      before(:each) { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:skills)).to eq([skill]) }
    end

    describe "GET 'show'" do
      before(:each) { get :show, { id: skill.to_param } }

      it { expect(response).to be_success }
    end

    describe "GET 'new'" do
      before(:each) { get :new }

      it { expect(assigns(:skill)).to be_a_new Skill }
      it { expect(response).to be_success }
    end

    describe "POST 'create'" do
      describe "persistance" do
        it "saves skill with valid parameters" do
          expect {
            post :create, { skill: attributes_for(:skill) }
          }.to change(Skill, :count).by(1)
        end

        it "rejects skill with invalid parameters" do
          expect {
            post :create, { skill: { name: "" } }
          }.to change(Skill, :count).by(0)
        end
      end

      describe "response behavior" do
        context "with valid parameters" do
          let(:valid_attributes) { attributes_for :skill }
          before(:each) { post :create, { skill: valid_attributes } }

          it { expect(assigns(:skill)).to be_a Skill }
          it { expect(assigns(:skill)).not_to be_new_record }
          it { expect(assigns(:skill).name).to eq(valid_attributes[:name]) }
          it { expect(response).to redirect_to admin_skills_path }
          it { expect(flash[:notice]).to eq("Skill successfully created.") }
        end

        context "with invalid parameters" do
          let(:invalid_attributes) { {name: ""} }
          before(:each) { post :create, { skill: invalid_attributes } }

          it { expect(assigns(:skill)).to be_a Skill }
          it { expect(assigns(:skill)).to be_new_record }
          it { expect(response).to render_template :new }
        end
      end
    end

    describe "GET 'edit'" do
      before(:each) { get :edit, { id: skill.to_param } }

      it { expect(response).to be_success }
      it { expect(assigns(:skill)).to eq skill }
    end

    describe "PUT 'update'" do
      context "with valid parameters" do
        let(:valid_attributes) { { name: "New Skill Name" } }
        before(:each) { put :update, { id: skill.to_param, skill: valid_attributes } }

        it { expect(response).to redirect_to admin_skills_path }
        it { expect(assigns(:skill)).to eq skill }
        it { expect(assigns(:skill).name).to eq "New Skill Name" }
        it { expect(assigns(:skill).changed?).to be_false }
        it { expect(flash[:notice]).to eq "Skill successfully updated." }
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { { name: "" } }
        before(:each) { put :update, { id: skill.to_param, skill: invalid_attributes} }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:skill)).to eq skill }
        it { expect(assigns(:skill).changed?).to be_true }
      end
    end

    describe "DELETE 'destroy'" do
      describe "persistance" do
        it "removes skill from database" do
          expect {
            delete :destroy, { id: skill.to_param }
          }.to change(Skill, :count).by(-1)
        end
      end

      describe "response behavior" do
        before(:each) { delete :destroy, { id: skill.to_param } }

        it { expect(assigns(:skill)).to eq skill }
        it { expect(response).to redirect_to admin_skills_path }
        it { expect(flash[:notice]).to eq "Skill successfully deleted." }
      end


    end
  end
end
