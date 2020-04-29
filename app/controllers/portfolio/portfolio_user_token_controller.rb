class Memipedia::MemipediaUserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token
end
