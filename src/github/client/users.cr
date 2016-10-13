require "../response/user"

module Github
  class Client
    module Users
      def user(user = nil, options = {} of String => String)
        Response::User.from_response get user_path(user)
      end

      private def user_path(user)
        case user
        when String
          "/users/#{user}"
        when Int32
          "/user/#{user}"
        else
          "/user"
        end
      end
    end
  end
end
