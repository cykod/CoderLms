
module PermalinkSupport
  extend ActiveSupport::Concern

  included do
    class_attribute :permalink_scope
  end

  class_methods do

    def has_permalink(scope_setting)
      before_save :set_permalink

      self.permalink_scope = scope_setting
    end
  end

  def permalink_string
    name
  end

  def permalink_base
    permalink_string.to_s.mb_chars.normalize(:kd).strip.downcase.gsub("'",'').gsub(/[^a-z+0-9\-]+/," ").strip.gsub(/[ _\-]+/,"-")
  end

  def set_permalink
    if self.name_changed?
      base = permalink_base

      idx = 1
      self.permalink = base
      while self.instance_exec(&permalink_scope).where(permalink: self.permalink).where("id != ?",self.id || 0).first
        idx += 1
        self.permalink = base + "-#{idx}"
      end
    end
  end
end
