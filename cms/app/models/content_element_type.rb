class ContentElementType < ActiveRecord::Base

  belongs_to :content_type
  has_many :content_elements, :dependent => :destroy

  validates_presence_of :name, :intern


  def simple_form

    unless ausgabe = Constant.fields(:id => self.field_type).value
      ausgabe = 'textfield'
    end

    return ausgabe
  end




  def method_missing(name, args = nil)
    ausgabe = nil

    begin
      meta = YAML::load(self.meta)

      if meta && meta.send(name.to_sym)
        ausgabe = meta.send(name.to_sym)
      else
        ausgabe = 2 if name == 'rows'
        ausgabe = false if name == 'markdown'
        ausgabe = false if name == 'haml'
        ausgabe = false if name == 'html'
        ausgabe = false if name == 'wysiwyg'
        ausgabe = false if name == 'redactor'
        ausgabe = false if name == 'autosize'
      end
    rescue
    end

    return ausgabe

  end

end
