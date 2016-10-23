module Github
  module Error
    class ClientError < Exception
    end

    class BadRequest < ClientError
    end

    class UnprocessableEntity < ClientError
    end
  end
end
