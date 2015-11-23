class BoardAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    super
  end

  def updatable_by?(user)
    super
  end

  def deletable_by?(user)
    super
  end

end
