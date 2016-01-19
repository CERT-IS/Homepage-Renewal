class EventAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    user.operator?
  end

  def updatable_by?(user)
    user.operator?
  end

  def deletable_by?(user)
    user.operator?
  end

end