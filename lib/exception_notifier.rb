# Catch exception
class ExceptionNotifier < StandardError
  attr_reader :object
  @errors = []

  def initialize(object, message)
    @object = object
    super(message)
    self.class.errors << self
  end

  class << self
    attr_accessor :errors

    def all
      @errors
    end
  end
end
