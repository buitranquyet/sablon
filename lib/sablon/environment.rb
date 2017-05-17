module Sablon
  # Combines the user supplied context and template into a single object
  # to manage data during template processing.
  class Environment
    attr_reader :template
    attr_reader :numbering
    attr_reader :relationships
    attr_reader :context

    # returns a new environment with merged contexts
    def alter_context(context = {})
      new_context = @context.merge(context)
      Environment.new(nil, new_context, self)
    end

    private

    def initialize(template, context = {}, parent_env = nil)
      # pass attributes of the supplied environment to the new one or
      # create new references
      if parent_env
        @template = parent_env.template
        @numbering = parent_env.numbering
        @relationships = parent_env.relationships
      else
        @template = template
        @numbering = Numbering.new
        @relationships = Sablon::Processor::Relationships.new
      end
      #
      @context = Context.transform_hash(context)
    end
  end
end
