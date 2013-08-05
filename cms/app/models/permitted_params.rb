class PermittedParams < Struct.new(:params, :current_user)

  # Branch
  def branch
    params.require(:branch).permit(*branch_attributes)
  end

  def branch_attributes
    [:ref_id, :name, :hidden, :unattached, branch_routes_attributes: [:id, :language, :name, :route, :jump] ]
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
    [:ref_id, :name, :intern, :editor]
  end
  
  
  
  # ContentElementType
  def content_element_type
    params.require(:content_element_type).permit(*content_element_type_attributes)
  end

  def content_element_type_attributes
    [:ref_id, :name, :intern, :field_type, :mandatory, :badge, :meta, :position]
  end








  # content
  def content
    params.require(:content).permit(*content_attributes)
  end

  def content_attributes
    [:old_id, :ref_id, :project_id, :content_type_id, :alpha_datum, :omega_datum, :user_id, :status, content_element_attributes: [:content_id, :content_element_type_id, :language, :value, :status] ]
  end




  # ContentElement
  def content_element
    params.require(:content_element).permit(*content_element_attributes)
  end

  def content_element_attributes
    [:content_id, :content_element_type_id, :language, :value, :status]
  end








  # Project
  def project
    params.require(:project).permit(*project_attributes)
  end

  def project_attributes
    if current_user.admin?
      [:ref_id, :projects_id, :name, :description, :status]
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
      [:name, :surname, :email, :password, :password_confirmation, :remember_me, :admin]
    else
      [:name, :surname, :email, :password, :password_confirmation, :remember_me]
    end
  end
end
