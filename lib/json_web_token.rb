class JsonWebToken
  class << self
    require 'jwt'
    JWT_SECRET = Rails.application.secrets.secret_key_base

    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, JWT_SECRET)
    end

    def decode(token)
      begin
      body = JWT.decode(token, JWT_SECRET)
        if body then HashWithIndifferentAccess.new body[0] else return false end
      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        return false
      rescue JWT::DecodeError, JWT::VerificationError => e
        return false
      end
    end
  end
end