RspecApiDocumentation.configure do |config|
  config.format = :json
end

def json_response
  JSON.parse(response_body)
end
