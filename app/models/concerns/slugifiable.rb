module Slugifiable
  module InstanceMethods
    def slug
      self.name.downcase.gsub(/\s/, "-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      name = slug.gsub(/[-]/, " ")
      self.where('lower(name) = ?', name).first
    end
  end
end
