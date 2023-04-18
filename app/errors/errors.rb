# frozen_string_literal: true

module Errors
  class FactoryLander < StandardError; end
  class WrongInvoiceStatusError < FactoryLander; end
end
