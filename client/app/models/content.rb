class Content < ActiveRecord::Base

  has_many :content_elements, :dependent => :destroy
#  accepts_nested_attributes_for :content_elements, :allow_destroy => true



  belongs_to :project

  belongs_to :content_type

  has_many :content_elements, :dependent => :destroy

  has_many :ctbs, :class_name => "ContentToBranches", :dependent => :destroy
  has_many :branches, :through => :ctbs

  has_many :documentables, :as => :documentable, :dependent => :destroy
  has_many :documents, :through => :documentables


  has_many :content_relations, :dependent => :destroy
  has_many :inverse_content_relations, :class_name => "ContentRelation", :foreign_key => "relative_id"


  scope :by_crt_and_content_and_binder, ->(content_relation_type, content, binder) { where('contents.id IN(?)', ContentRelation.select(:relative_id).where(:content_relation_type => content_relation_type).where(:content_id => content.id).where(:binder_id => binder.id)) }

  scope :direct, -> { joins(:content_type).where('content_types.direct_edit = 1') }



  def value content_element_type, language
    self.content_elements.where('content_elements.content_element_type_id = ?', content_element_type).where('content_elements.language = ?', language).first
  end










  def field(ce)

    content_element = self.content_elements.by_intern(ce).first

  end















  def rep(language)

    repraesentant = ''
    self.content_elements.where('content_elements.language = ?', language).each do |ce|
      trenner = (repraesentant.empty?) ? '' : ' : '
      repraesentant = repraesentant + trenner + ce.value if ce.content_element_type.badge
    end

    repraesentant

  end

  def file(language)

    file = self.rep(language).downcase

    file = file.gsub('!', '')
    file = file.gsub(',', '')
    file = file.gsub(' ', '-')
    file = file.gsub('"', '')
    file = file.gsub('(', '')
    file = file.gsub(')', '')


    file = CGI::escape(file)

    return file
  end


  def filename(language)

    unless self.branches.empty?

      unless self.ctbs.link.empty?
        branch = self.ctbs.link.first.branch
      else
        branch = self.branches.first
      end
      filename = '/' + language.to_s + branch.route(language).route + '/' + self.file(language) + '.htm'

      filename = filename.downcase
    end
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
      elsif ce.content_element_type.markdown
        ausgabe = Kramdown::Document.new( ce.html, :auto_ids => false).to_html.html_safe
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
