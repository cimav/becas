class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where.not(user_type:User::SUPER_USER)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    custom_params = user_params
    # areas llega como un arreglo de strings y siempre con el primer elemento vacío así que se cambia el formato
    custom_params[:areas]= custom_params[:areas].drop(1).map(&:to_i)
    @user = User.new(custom_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuario creado.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      custom_params = user_params
      # areas llega como un arreglo de strings y siempre con el primer elemento vacío así que se cambia el formato
      custom_params[:areas]= custom_params[:areas].drop(1).map(&:to_i)
      if @user.update(custom_params)
        format.html { redirect_to @user, notice: 'Usuario actualizado' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.update(status:User::DELETED)
        format.html { redirect_to users_path, notice: 'Usuario eliminado' }
        format.json { render :index, status: :ok}
      else
        format.html { redirect_to @user, notice: 'Error al eliminar usuario' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:full_name, :email, :user_type, :status, areas:[])
    end
end
