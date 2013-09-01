class Content < ActiveRecord::Base

  has_many :content_elements, :dependent => :destroy
#  accepts_nested_attributes_for :content_elements, :allow_destroy => true



  belongs_to :project

  belongs_to :user

  belongs_to :content_type

  has_many :content_elements, :dependent => :destroy

  has_many :ctbs, :class_name => "ContentToBranches", :dependent => :destroy
  has_many :branches, :through => :ctbs


  has_many :documentables, :as => :documentable, :dependent => :destroy
  has_many :documents, :through => :documentables


  has_many :content_relations, :dependent => :destroy
  has_many :inverse_content_relations, :class_name => "ContentRelation", :foreign_key => "relative_id"
#  has_many :owned_content_relations, :class_name => "ContentRelation", :foreign_key => "owner_id", :dependent => :destroy




  
  scope :direct, -> { joins(:content_type).where('content_types.direct_edit = 1') }
  scope :by_filename, ->(filename) { joins(:content_elements).where("REPLACE(URLENCODE(VALUE) COLLATE utf8_unicode_ci, '%20', '+') = ?", filename) unless filename.nil? }


#       SELECT 		contents.id 														AS content_id,
#       			REPLACE(URLENCODE(VALUE) COLLATE utf8_unicode_ci, '%20', '+') 		AS filename
#       
#       FROM 		content_elements 
#       LEFT JOIN 	contents ON (contents.id = content_elements.content_id)
#       
#       WHERE		contents.project_id = 1
#       
#       HAVING 		filename = 'test+1'




  def value content_element_type, language
    self.content_elements.where('content_elements.content_element_type_id = ?', content_element_type).where('content_elements.language = ?', language).first
  end














  def proof_bracketcommands
    self.content_elements.each do |ce|

      unless ce.new_record?
        ce.value = ce.value.gsub(/\[img:(\d+)(?:\:(\d+))(?:\:(left|right))\]/).each do |doc|
        
          match,id,width,align = $&,$1,$2,$3
  
          match = recalulateimg(match,id,width)
        end
        ce.update_column( :value, ce.value ) if ce.value_changed?
  
  
        ce.value = ce.value.gsub(/\[img:(\d+)(?:\:(\d+))\]/).each do |doc|
        
          match,id,width = $&,$1,$2
  
          match = recalulateimg(match,id,width)
        end
        ce.update_column( :value, ce.value ) if ce.value_changed?
      end

    end
  end
  # http://jimneath.org/2010/01/04/cryptic-ruby-global-variables-and-their-meanings.html





  def recalulateimg(match,id,width)
  
    puts "recalulateimg(#{match},#{id},#{width})"
  
    if document = Document.where('documents.id = ?', id).first
      if width.present?
        case document.document_content_type
          when /^image/

            unless File.exists?(document.document.path("width#{width}"))

              dst_dir_name = "#{Rails.root}/public/uploads/#{document.project.intern}/documents/#{document.id}/width#{width}/"
              FileUtils.mkdir_p( dst_dir_name )

              src_file_name = document.document.path(:original)
              dst_file_name = "#{dst_dir_name}#{File.basename(src_file_name)}"


              command_line = Cocaine::CommandLine.new( "#{PAPERCLIP_COMMAND_PATH}convert", "#{src_file_name} -resize #{width} #{dst_file_name}" )

              begin
                command_line.run
              rescue Cocaine::ExitStatusError => e
                puts e.message # => "Command 'git commit' returned 1. Expected 0"
              end

              # Quelle: https://github.com/thoughtbot/cocaine

            end
          # end "when /^image/"
        end

      end # if width.present?
    else
      puts 'remove match '
      match = ""    # Fundstelle [img...] kann weg, weil Documentable ist mehr existiert
    end
  
    return match
  
  end





  def relations(crt)
    ausgabe = []

    self.content_relations.by_content_relation_type(crt).each do |cr|
      ausgabe << cr
    end
    
    return ausgabe
  end








  def rep(language)

    repraesentant = ''
    self.content_elements.where('content_elements.language = ?', language).each do |ce|
      trenner = (repraesentant.empty?) ? '' : ' : '
      repraesentant = repraesentant + trenner + ce.value if ce.content_element_type.badge
    end
    
    repraesentant

  end
  
  
  def languages
  
    languages = []
  
    self.content_elements.group(:language).each do |ce| 
      languages << ce.language
    end
    
    languages
  end
  
  
  
  def option(name, args = nil)
    ausgabe = nil
    
    meta = YAML::load(self.content_type.meta)

    if meta && meta.send(name.to_sym)
      ausgabe = meta.send(name.to_sym)
    end
      
    return ausgabe

  end
  
  
  
  
  
  
  
  
  def reorder_documents(args = {})
    
    documentable = self.documentables.where(:document_id => args[:document]).first
    documentable.position = args[:position]
    documentable.save

  end
  
  def reorder_content_relations(args = {})
    
    relation = self.content_relations.where(:relative_id => args[:relative]).first
    relation.position = args[:position]
    relation.save

  end
  
  
  
  def method_missing(name, args = nil)
    ausgabe = nil

    ce = self.content_elements.includes(:content_element_type).where('content_element_types.intern = ?', name).references(:content_element_types)

    if args && args[:locale]
      ce = ce.where('content_elements.language = ?', args[:locale]).first
    elsif I18n.locale
      ce = ce.where('content_elements.language = ?', I18n.locale).first
    else
      ce = ce.first
    end
    
    if ce
      if ce.content_element_type.field_type == 'ContentType'
        reference = self.project.contents.where(:id => ce.value ).first
        if reference
          ausgabe = reference.rep(I18n.locale)
        end
      elsif ce.content_element_type.field_type == 'boolean'
        ausgabe = ( ce.value == 'true' ) ? true : false
      else
        ausgabe = ce.value 
      end
    end

    unless ausgabe
    
      content_relations = self.content_relations.includes(:content_relation_type).where('content_relation_types.intern = ?', name).references(:content_relation_type)
      unless content_relations.empty?
        ausgabe = []
        content_relations.each do |cr|        
          ausgabe << { :id => cr.relative.id, :repraesentant => cr.relative.rep(I18n.locale), :content => cr.relative }
        end
      
      end
      
    
    end

    return ausgabe
  end


end
