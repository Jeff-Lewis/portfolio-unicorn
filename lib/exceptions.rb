module Exceptions
  class JobError < StandardError; end
  class ResourceTypeError < JobError; end

  class ExchangeNotFoundError < JobError; end
  class MissingParameterError < JobError; end
end