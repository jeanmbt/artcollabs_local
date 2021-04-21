class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # ASSING POLICIES FOR PROJECTS SO THAT ONLY TEAM MEMBERS CAN SEE ADDITIONAL INFO

  def index?
    true
  end

  def tagged?
    true
  end
  
  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.user == user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.admin?
  end

  def media?
    true
  end
  
end
