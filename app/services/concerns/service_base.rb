module ServiceBase
  extend ActiveSupport::Concern
  included do
    class << self
      protected :new
      def call(params={})
        new(params).call
      end
    end
  end

  def initialize(params)
    params.each do |attr, value|
      value.each do |key, value|
        self.send("#{key}", value)
      end
    end if params
  end

  def call
    raise StandardError.new('Must override `call` instance method.')
  end
end
