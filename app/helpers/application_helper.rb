module ApplicationHelper
    def profile_img(user)
        return image_tag(user.avatar, alt: user.name,:size => "200x200") if user.avatar?

        unless user.provider.blank?
            img_url = user.image_url
        else
            img_url = 'no_image.png'
        end
        image_tag(img_url, alt: user.name, :size => "200x200")
    end
    
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
     devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  

end
