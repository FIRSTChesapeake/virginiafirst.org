require 'spec_helper'

describe Admin::GamesController do

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
    let(:user) { create :user }
    let!(:game) { create :game }
    before(:each) { sign_in user }

    context "with program and invalid game" do
      let(:program) { create :ftc_program }
      {
          show: "get",
          edit: "get",
          update: "put",
          destroy: "delete"
      }.each do |action, method|
        it "raises RecordNotFound error" do
          expect {
            send(method, action, { id: game.to_param, program: program.to_param})
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end

    end

    describe "GET 'index'" do
      before(:each) { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:games)).to eq([game]) }
    end

    describe "GET 'show'" do
      before(:each) { get :show, { id: game.to_param } }

      it { expect(response).to be_success }
      it { expect(assigns(:game)).to eq game }
    end

    describe "GET 'new'" do
      before(:each) { get :new }

      it { expect(response).to be_success }
      it { expect(assigns(:game)).to be_new_record }
      it { expect(assigns(:game)).to be_an_instance_of Game }
    end

    describe "POST 'create'" do
      let(:program) { create :frc_program }
      let(:valid_attributes) { attributes_for :game, program_id: program.id }

      describe "persistence" do
        context "with valid parameters" do
          it "saves game to database" do
            expect {
              post :create, { game: valid_attributes }
            }.to change(Game, :count).by(1)
          end
        end

        context "with invalid parameters" do
          it "does not save game to database" do
            expect {
              post :create, { game: {} }
            }.to change(Game, :count).by(0)
          end
        end
      end

      describe "response behavior" do
        context "with valid parameters" do
          before(:each) { post :create, { game: valid_attributes } }

          it { expect(response).to redirect_to admin_games_path }
          it { expect(assigns(:game)).to be_a Game }
          it { expect(assigns(:game)).not_to be_new_record }
          it { expect(assigns(:game).name).to eq valid_attributes[:name] }
          it { expect(flash[:notice]).to eq("Game successfully created.") }
        end

        context "with invalid parameters" do
          let(:invalid_attributes) { {} }
          before(:each) { post :create, { game: invalid_attributes } }

          it { expect(assigns(:game)).to be_a Game }
          it { expect(assigns(:game)).to be_new_record }
          it { expect(response).to render_template :new }
        end

        context "with program parameter" do
          let(:program) { create :ftc_program }
          let(:attributes) { attributes_for :game }
          before(:each) { post :create, { program: program.code, game: attributes } }

          it { expect(assigns(:game).program).to eq program }
          it { expect(assigns(:program)).to eq program }
          it { expect(response).to redirect_to admin_games_path(program) }
        end
      end
    end

    describe "GET 'edit'" do
      before(:each) { get :edit, { id: game.to_param } }

      it { expect(response).to be_success }
      it { expect(assigns(:game)).to eq game }
    end

    describe "PUT 'update'" do
      context "with valid parameters" do
        let(:valid_attributes) { { name: "Change Game Name" } }
        before(:each) { put :update, { id: game.to_param, game: valid_attributes } }

        it { expect(response).to redirect_to admin_games_path }
        it { expect(assigns(:game)).to eq game }
        it { expect(assigns(:game).name).to eq "Change Game Name" }
        it { expect(assigns(:game).changed?).to be_false }
        it { expect(flash[:notice]).to eq "Game successfully updated." }
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { { name: "" } }
        before(:each) { put :update, { id: game.to_param, game: invalid_attributes } }

        it { expect(response).to render_template :edit }
        it { expect(assigns(:game)).to eq game }
        it { expect(assigns(:game).changed?).to be_true }
      end

      context "with program parameter" do
        let(:attributes) { {} }
        before(:each) { put :update, { id: game.to_param, program: game.program.code, game: attributes } }

        it { expect(assigns(:program)).to eq game.program }
        it { expect(response).to redirect_to admin_games_path(game.program) }
      end
    end

    describe "DELETE 'destroy'" do
      describe "persistence" do
        it "deletes game from the databse" do
          expect {
            delete :destroy, { id: game.to_param }
          }.to change(Game, :count).by(-1)
        end
      end

      describe "response behavior" do
        before(:each) { delete :destroy, { id: game.to_param } }

        it { expect(response).to redirect_to admin_games_path }
        it { expect(assigns(:game)).to eq game }
        it { expect(flash[:notice]).to eq "Game successfully deleted." }
      end

      context "with program parameter" do
        before(:each) { delete :destroy, { id: game.to_param, program: game.program.code } }

        it { expect(response).to redirect_to admin_games_path(game.program) }
      end
    end
  end
end
