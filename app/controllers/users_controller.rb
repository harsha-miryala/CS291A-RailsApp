class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def index
        @users = User.all
    end

    def show
        begin
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render :json => "404 Not found"
        end
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])

        #if @user != current_user
        #    redirect_to root_path, notice: "Sorry, but you are only allowed to edit your own profile."
        #end
    end

    def create
        puts "Reached create method of Users"
        puts user_params
        @user = User.new(user_params)
        if @user.save
            redirect_to @user, notice: 'User was successfully created.'
        else
            puts "reached invalid case"
            render :new, status: :unprocessable_entity # 422 error
        end
    end

    def update
        if @user.update(user_params)
            redirect_to @user, notice: 'User was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        puts "Reached destroy method"
        @user = User.find(params[:id])
        @user.destroy
        User.delete(@user)
        puts users_url
        redirect_to users_url, notice: 'User was successfully destroyed.'
    end

    private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:name, :email)
    end
end
