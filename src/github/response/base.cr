require "../error"

module Github
  module Response
    class Base
      def self.from_response(response)
        status = response.status_code
        body = response.body
        # headers = response.headers

        case status
        when 400 then raise error_for_400(body)
          # when      401 then raise error_for_401(headers, body)
          # when      403 then raise error_for_403(body)
          # when      404 then raise Error::NotFound.new body, nil
          # when      405 then raise Error::MethodNotAllowed.new body, nil
          # when      406 then raise Error::NotAcceptable.new body, nil
          # when      409 then raise Error::Conflict.new body, nil
          # when      415 then raise Error::UnsupportedMediaType.new body, nil
        when 422 then raise
          # when      451 then raise Error::UnavailableForLegalReasons.new body, nil
          # when 400..499 then raise Error::ClientError.new body, nil
          # when      500 then raise Error::InternalServerError.new body, nil
          # when      501 then raise Error::NotImplemented.new body, nil
          # when      502 then raise Error::BadGateway.new body, nil
          # when      503 then raise Error::ServiceUnavailable.new body, nil
          # when 500..599 then raise Error::ServerError.new body, nil
        end

        from_json(body)
      end

      def self.error_for_400(body)
        message = JSON.parse(body)["message"]
        Error::BadRequest.new message: message.to_s
      end

      def self.error_422(body)
        body = JSON.parse(body)
        message = body["message"]
        errors = body["erros"]
        Error::UnprocessableEntity.new body, nil
      end

      def self.error_for_401(headers, body)
        if Error::OneTimePasswordRequired.required_header(headers)
          Error::OneTimePasswordRequired.new body, nil
        else
          Error::Unauthorized.new body, nil
        end
      end

      def self.error_for_403(body)
        if body =~ /rate limit exceeded/i
          Error::TooManyRequests.new body, nil
        elsif body =~ /login attempts exceeded/i
          Error::TooManyLoginAttempts.new body, nil
        elsif body =~ /abuse/i
          Error::AbuseDetected.new body, nil
        elsif body =~ /repository access blocked/i
          Error::RepositoryUnavailable.new body, nil
        elsif body =~ /email address must be verified/i
          Error::UnverifiedEmail.new body, nil
        elsif body =~ /account was suspended/i
          Error::AccountSuspended.new body, nil
        else
          Error::Forbidden.new body, nil
        end
      end
    end
  end
end
