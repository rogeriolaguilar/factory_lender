# frozen_string_literal: true

def parsed_body(response)
  JSON.parse(response.body, symbolize_names: true)
end
