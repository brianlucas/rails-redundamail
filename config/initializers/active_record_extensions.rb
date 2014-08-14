module ActiveRecordExtension

  extend ActiveSupport::Concern
    
  def has_errors?
     respond_to?(:errors) && !errors.empty?
  end
  
  # add your static(class) methods here
  module ClassMethods
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)