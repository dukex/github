require "./spec_helper"

class Github::Response::Base
  def self.from_json(_d)
  end
end

describe Github::Response::Base do
  describe "#from_response" do
    context "with status code 400" do
      response = HTTP::Client::Response.new 400, "{\"message\": \"Problems parsing JSON\"}"

      it "raises BadRequest" do
        expect_raises Github::Error::BadRequest, "Problems parsing JSON" {
          Github::Response::Base.from_response(response)
        }
      end
    end

    context "with status code 422" do
      response = HTTP::Client::Response.new 422, "{\"message\": \"Validation Failed\"}"

      it "raises UnprocessableEntity" do
        expect_raises Github::Error::UnprocessableEntity, "Problems parsing JSON" {
          Github::Response::Base.from_response(response)
        }
      end
    end
  end
end
