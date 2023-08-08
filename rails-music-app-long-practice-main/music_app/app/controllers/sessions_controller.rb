class SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Invalid Credentials']
            @user = User.new(email: params[:user][:email])
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def destroy
        logout!
        flash[:messages] = ['Succesfully logged out']
        redirect_to new_session_url
    end
end
