# frozen_string_literal: true

D = Steep::Diagnostic

target :lib do
  signature "sig"

  check "lib"
  # ignore "lib/.../*.rb"

  library "base64"
  library "bigdecimal"
  library "date"
  library "json"
  library "openssl"
  library "time"
  library "uri"

  configure_code_diagnostics(D::Ruby.strict)
end
