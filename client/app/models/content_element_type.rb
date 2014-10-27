class ContentElementType < ActiveRecord::Base

  belongs_to :content_type
  has_many :content_elements#, :dependent => :destroy

  validates_presence_of :name, :intern


  default_scope { order('content_element_types.position ASC') }


  def simple_form

    unless ausgabe = Constant.fields(:id => self.field_type).value
      ausgabe = 'textfield'
    end

    return ausgabe
  end


  def markdown
    ausgabe = false
    if self.meta
      meta = YAML::load(self.meta)
      ausgabe = meta.send(:markdown) if meta
    end

    return ausgabe

  end




  def self.method_missing(name, args = nil)
    ausgabe = nil

    if self.meta
      begin
        meta = YAML::load(self.meta)

        if meta && meta.send(name.to_sym)
          ausgabe = meta.send(name.to_sym)
        else
          ausgabe = 2 if name == 'rows'
          ausgabe = false if name == 'markdown'
        end
      rescue
        ausgabe = false
      end
    end

    return ausgabe

  end

end
