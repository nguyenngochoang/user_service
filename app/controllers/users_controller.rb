class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    raise "Something went wrong" unless user.save

    payload = {user: user}
    private_key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_API_KEY'].gsub("\\n", "\n"))
    token = JWT.encode payload, private_key, 'RS256'

    render json: { token: token }
  end

  def info
    user_email = decode_token[0]["user_email"]
    user = User.find_by(email: user_email)
    raise "User not found" unless user

    render json: {user: user}
  end

  private

    def decode_token
      private_key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_API_KEY'])
      JWT.decode params[:user_token], private_key.public_key, true, { algorithm: 'RS256' } if params[:user_token] # email
    end

    def user_params
      params.require(:user).permit(User::USER_PARAMS)
    end

end
