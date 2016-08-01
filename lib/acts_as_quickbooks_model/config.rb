module ActsAsQuickbooksModel
  class Config
    attr_accessor :doc_path, :definitions_path, :migrations_path, :model_maps_path

    ##
    # @param [Hash{Symbol=>Object}] options the hash to be used to build the
    #   config
    def initialize(options = {})
      self.doc_path = "#{ActsAsQuickbooksModel.root}/doc"

      options.each_pair { |option, value| set_option(option, value) }

      self.definitions_path ||= "#{doc_path}/definitions"
      self.migrations_path ||= "#{doc_path}/migrations"
      self.model_maps_path ||= "#{doc_path}/model_maps"

      self
    end

    private

    def set_option(option, value)
      __send__("#{option}=", value)
    rescue NoMethodError
      fail "Unknown option '#{option}'"
    end
  end
end
