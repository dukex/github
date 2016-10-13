require "../error"

module Github
  module Response
    class Base
      def self.from_response(response)
        status = response.status_code
        body = response.body
        headers = response.headers

        case status
        when      400 then raise Error::BadRequest.new nil
        when      401 then raise error_for_401(headers, body)
        when      403 then raise error_for_403(body)
        when      404 then raise Error::NotFound.new nil
        when      405 then raise Error::MethodNotAllowed.new nil
        when      406 then raise Error::NotAcceptable.new nil
        when      409 then raise Error::Conflict.new nil
        when      415 then raise Error::UnsupportedMediaType.new nil
        when      422 then raise Error::UnprocessableEntity.new nil
        when      451 then raise Error::UnavailableForLegalReasons.new nil
        when 400..499 then raise Error::ClientError.new nil
        when      500 then raise Error::InternalServerError.new nil
        when      501 then raise Error::NotImplemented.new nil
        when      502 then raise Error::BadGateway.new nil
        when      503 then raise Error::ServiceUnavailable.new nil
        when 500..599 then raise Error::ServerError.new nil
        end

        from_json(body)
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
          Error::TooManyRequests.new nil, nil
        elsif body =~ /login attempts exceeded/i
          Error::TooManyLoginAttempts.new nil, nil
        elsif body =~ /abuse/i
          Error::AbuseDetected.new nil, nil
        elsif body =~ /repository access blocked/i
          Error::RepositoryUnavailable.new nil, nil
        elsif body =~ /email address must be verified/i
          Error::UnverifiedEmail.new nil, nil
        elsif body =~ /account was suspended/i
          Error::AccountSuspended.new nil, nil
        else
          Error::Forbidden.new nil, nil
        end
      end
    end
  end
end
