class Admin::GamesController < Admin::BaseController
  before_filter :load_game, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
    @game = Game.new params[:game]

    if params[:program].present?
      @program = FirstProgram.find_by_code params[:program]
      @game.program = @program
    end

    respond_to do |format|
      if @game.save
        format.html { redirect_to admin_games_path(@program), notice: "Game successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @game.update_attributes params[:game]
        format.html { redirect_to admin_games_path(@program), notice: "Game successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @game.destroy

    redirect_to admin_games_path(@program), notice: "Game successfully deleted."
  end

  private

  def load_game
    if @program
      @game = @program.games.find params[:id]
    else
      @game = Game.find params[:id]
    end
  end
end
