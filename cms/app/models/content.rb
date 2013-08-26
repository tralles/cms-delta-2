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
  has_many :inverse_content_relations, :class_name => "ContentRelation", :foreign_key => "relative_id", :dependent => :destroy
#  has_many :owned_content_relations, :class_name => "ContentRelation", :foreign_key => "owner_id", :dependent => :destroy


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
  
  
  
  def method_missing(name, args = nil)
    ausgabe = nil

    ce = self.content_elements.includes(:content_element_type).where('content_element_types.intern = ?', name).references(:content_element_types)

    if @locale
      ce = ce.where('content_elements.language = ?', @locale).first
    elsif args && args[:locale]
      ce = ce.where('content_elements.language = ?', args[:locale]).first
    else
      ce = ce.first
    end

    ausgabe = ce.value if ce 

    return ausgabe
  end


end
