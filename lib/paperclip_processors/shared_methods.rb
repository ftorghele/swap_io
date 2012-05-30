module PaperclipProcessors
  module SharedMethods

    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def image_geometry(style = :original)
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
    end

    private

    def reprocess_image
      image.reprocess!
    end

  end
end
