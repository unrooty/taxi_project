require 'dry/matcher'
module Matcher
  def match(cases)
    check(cases)
  end

  private

  def check(cases)
    @cases = {}
    @existing_cases = %w[success created unauthorized not_found invalid]
    @existing_cases.each do |c|
      if cases.include?(c)
        cases.delete(c)
        @cases[c.to_sym] = method(c.to_sym).call
      end
    end
    unless cases.empty?
      raise ArgumentsUndefined,
            "Cases #{cases.join(',')} undefined."
    end
    Dry::Matcher.new(@cases)
  end

  def success
    Dry::Matcher::Case.new(
      match:   ->(result) { result.success? },
      resolve: ->(result) { result }
    )
  end

  def created
    Dry::Matcher::Case.new(
      match:   ->(result) { result.success? && result['model.action'] == :new },
      resolve: ->(result) { result }
    )
  end

  def unauthorized
    Dry::Matcher::Case.new(
      match:   lambda do |result|
        result.failure? &&
        !result['result.policy.default'].nil? &&
        result['result.policy.default'].failure?
      end,
      resolve: ->(result) { result }
    )
  end

  def not_found
    Dry::Matcher::Case.new(
      match:   lambda do |result|
        result.failure? &&
        result['result.model'] &&
        result['result.model'].failure?
      end,
      resolve: ->(result) { result }
    )
  end

  def invalid
    Dry::Matcher::Case.new(
      match:   lambda do |result|
        result.failure? &&
        result['result.contract.default'] &&
        result['result.contract.default'].failure?
      end,
      resolve: ->(result) { result }
    )
  end

  class ArgumentsUndefined < StandardError
    def initialize(msg)
      super
    end
  end
end
