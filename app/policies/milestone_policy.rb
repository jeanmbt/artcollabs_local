class MilestonePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # ASSING POLICIES FOR PROJECT SHOW PAGE SO THAT ONLY TEAM MEMBERS CAN SEE MILESTONES

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def status?
    true
  end
  
end
