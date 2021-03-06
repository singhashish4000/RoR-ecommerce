class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
    @user = User.new(user_params.except(:property_ids))
    p params
    p params[:property_ids]
    respond_to do |format|
      if @user.save
        p "###########################"
        user_params[:property_ids].each_with_index do |property_id, index|
          if index != 0
            p @user.user_properties.create(property_id: property_id)
          end
        end
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :user_path, status: :created, location: @user }
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
      if @user.update(user_params.except(:property_ids))
        p "###########################"
        @user.user_properties.destroy_all
        user_params[:property_ids].each_with_index do |property_id, index|
          if index != 0
            p @user.user_properties.create(property_id: property_id)
          end
        end
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name,:email,:phone, property_ids: [])
    end
end
