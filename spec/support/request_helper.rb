# frozen_string_literal: true

def parsed_body(_body)
  JSON.parse(response.body, symbolize_names: true)
end
