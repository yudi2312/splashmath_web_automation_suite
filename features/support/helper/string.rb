class String

  def formatize
    self.downcase.tr(' ', '_')
  end

  def deformatize
    self.tr('_', ' ')
  end

end