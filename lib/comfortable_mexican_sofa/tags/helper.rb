class ComfortableMexicanSofa::Tag::Helper
  include ComfortableMexicanSofa::Tag
  
  PROTECTED_METHODS = %w(eval class_eval instance_eval)
  
  def self.regex_tag_signature(identifier = nil)
    identifier ||= /\w+/
    /\{\{\s*cms:helper:(#{identifier}):?(.*?)\s*\}\}/
  end
  
  def content
    if ComfortableMexicanSofa.configuration.allow_irb ||
          (!ComfortableMexicanSofa.configuration.allowed_helpers.nil? && identifier =~ ComfortableMexicanSofa.configuration.allowed_helpers) ||
          (ComfortableMexicanSofa.configuration.allowed_helpers.nil? && identifier !~ ComfortableMexicanSofa.configuration.disabled_helpers)
      "<%= #{identifier}(#{params.collect{|p| "'#{self.class.sanitize_parameter(p)}'"}.join(', ')}) %>"
    else
      ""
    end
  end
  
  def render
    content if !PROTECTED_METHODS.member?(identifier) || ComfortableMexicanSofa.config.allow_irb
  end
  
end