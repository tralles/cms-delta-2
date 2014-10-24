class ContentRelationsController < ApplicationController

  around_filter :wrap_in_transaction, :only => [:create]



  def new
    @content_relation                         = ContentRelation.new

    @content                                  = @project.contents.where(:id => params[:content_id]).first
    @content_relation_type                    = @project.content_relation_types.where(:id => params[:content_relation_type_id]).first
    @content_type                             = @content_relation_type.relative_type

    @content_relation.content                 = @content
    @content_relation.content_relation_type   = @content_relation_type
  end # new



  def create

      @content_relation                         = ContentRelation.new

      @content                                  = @project.contents.where(:id => params[:content_id]).first
      @content_relation_type                    = @project.content_relation_types.where(:id => params[:content_relation_type_id]).first
      @content_type                             = @content_relation_type.relative_type


      @content_relation.content                 = @content
      @content_relation.content_relation_type   = @content_relation_type


      @relative = Content.new

      @relative.project        = @project
      @relative.content_type   = @content_type

      @relative.ref_id         = params[:ref]

      if @relative.save

        if params[:content_elements][:add]
          params[:content_elements][:add].each do |content_element_type, value|
            @relative.content_elements.build(:content_element_type_id => content_element_type, :language => @locale, :value => value).save
          end
        end
        @relative.proof_bracketcommands

        @content_relation.relative = @relative

        if @content_relation.save
        else
          @errors = false
        end
      end

  end # create



  def bind
    content_relation_type     = ContentRelationType.find(params[:content_relation_type_id])
    content                   = Content.find(params[:content_id])
    binder                    = Content.find(params[:binder_id])
    relative                  = Content.find(params[:relative_id])

    @crid                     = params[:crid]

    if content.project == binder.project && content.project  == relative.project
      @content_relation                       = ContentRelation.new
      @content_relation.content_relation_type = content_relation_type
      @content_relation.content               = content
      @content_relation.binder                = binder
      @content_relation.relative              = relative

      if @content_relation.save
        @bindingcontents = ContentRelation.by_crt_and_content_and_binder(content_relation_type, content, binder)
      end
    end
  end

  def unbind
    @content_relation                       = ContentRelation.find(params[:content_relation_id])
    @content_relation.destroy
  end

  def destroy

#    @content = Content.find(params[:content_id])
#    @crt     = ContentRelationType.find(params[:content_relation_type_id])
    @cr      = ContentRelation.find(params[:id])

    @relative_id  = @cr.relative.id
    if @relative_id
      @cr.destroy
    end
  end # destroy



  def sort
    nummer = 1

    @content = Content.find(params[:content_id])

    params[:relative].each do |relative|
      @content.reorder_content_relations :relative => relative, :position => nummer
      nummer = nummer + 1
    end

    render json: {:success => true }
  end


  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      yield
    end
  end

end
