module Api
  module V1
    class UsersController < ApplicationController
      def sign_in
        response = UserService.sign_in(user_params)
        render json: { user: response.success? ? response.user : response.message },
               status: response.status_code
      end

      def sign_up
        response = UserService.sign_up(user_params)
        render json: { user: response.success? ? response.user : response.message },
               status: response.status_code
      end

      private

      def user_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end
