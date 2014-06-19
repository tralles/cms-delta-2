class PermittedParams < Struct.new(:params, :current_user)

  # Branch
  def branch
    params.require(:branch).permit(*branch_attributes)
  end

  def branch_attributes
    [:ref_id, :name, :hidden, :unattached, :content_type_ids => [], :branch_routes_attributes => [:id, :language, :name, :route, :jump] ]
  end




  # Route
  def branch_route
    params.require(:branch_route).permit(*branch_route_attributes)
  end

  def branch_route_attributes
    [:id, :language, :name, :route, :jump]
  end




  # ContentType
  def content_type
    params.require(:content_type).permit(*content_type_attributes)
  end

  def content_type_attributes
    [:ref_id, :name, :intern, :editor, :meta, :direct_edit]
  end



  # ContentElementType
  def content_element_type
    params.require(:content_element_type).permit(*content_element_type_attributes)
  end

  def content_element_type_attributes
    [:ref_id, :name, :intern, :field_type, :mandatory, :badge, :meta, :position, :inline_documents]
  end



  # ContentRelationType
  def content_relation_type
    params.require(:content_relation_type).permit(*content_relation_type_attributes)
  end

  def content_relation_type_attributes
    [:name, :intern, :content_type_id, :relative_type_id, :relation_type, :binder_type_id]
  end








  # content
  def content
    params.require(:content).permit(*content_attributes)
  end

  def content_attributes
    [:old_id, :ref_id, :project_id, :content_type_id, :alpha_datum, :omega_datum, :branch_ids => [], :workspace_ids => [], :content_element_attributes => [:content_id, :content_element_type_id, :language, :value, :status] ]
  end




  # ContentElement
  def content_element
    params.require(:content_element).permit(*content_element_attributes)
  end

  def content_element_attributes
    [:content_id, :content_element_type_id, :language, :value, :status]
  end





  # Document
  def document
    params.require(:document).permit(*document_attributes)
  end

  def document_attributes
    [:doctype, :document]
  end



  # Documentable
  def documentable
    params.require(:documentable).permit(*documentable_attributes)
  end

  def documentable_attributes
    [:doctype, :title, :info]
  end



  # Project
  def project
    params.require(:project).permit(*project_attributes)
  end

  def project_attributes
    if current_user.admin?
      [:ref_id, :projects_id, :intern, :name, :description, :status, :analytics]
    else
      [:name, :description]
    end
  end



  # User
  def user
    params.require(:user).permit(*user_attributes)
  end

  def user_attributes
    if current_user.admin?
      [:name, :surname, :email, :password, :password_confirmation, :remember_me, :admin, :project_ids => []]
    else
      [:name, :surname, :email, :password, :password_confirmation, :remember_me]
    end
  end
end
