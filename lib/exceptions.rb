module Exceptions
  class JobError < StandardError; end
  class ResourceTypeError < JobError; end
end