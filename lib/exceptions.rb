module Exceptions
  class JobError < StandardError; end
  class ResourceTypeError < JobError; end

  class ExchangeNotFoundError < JobError; end
end