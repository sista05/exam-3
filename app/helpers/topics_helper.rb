module TopicsHelper
    def topic_img(topic)
        return image_tag(topic.image) if topic.image?

        unless topic.image.blank?
            img_url = topic.image
        else
            img_url = 'no_image.png'
        end
        image_tag(img_url)
    end
end
