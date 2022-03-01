class MembersController < ApplicationController
    before_action :authenticate_user!

    def show
        user = get_user_from_token
        render json: {
            message: "If you see this, you're in!",
            user: user
        }
    end

    private
    def get_user_from_token
        jwt_playload = JWT.decode(request.headers['Autorization'].split(' ')[1],
           Rails.application.credentials.devise[:jwt_sectret_key]).first
           user_id = jwt_playload['sub']
           user = User.find(user_id.to_s)
    end
end
         