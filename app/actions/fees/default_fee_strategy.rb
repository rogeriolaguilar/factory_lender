# frozen_string_literal: true

module Fees
  class DefaultFeeStrategy
    DEFAULT_RATE = 0.01
    def initialize(rate = DEFAULT_RATE)
      @rate = rate
    end

    def accrue_fee(amount, period)
      fees = (1 + @rate)**period
      amount - fees
    end
  end
end
