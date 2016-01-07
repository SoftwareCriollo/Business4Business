class Ability
  include CanCan::Ability

  def initialize(company)
    # Define abilities for the passed in user here. For example:
    #
    company ||= Company.new(type:'Guest') # guest user (not logged in)
    if company.is_team_company?
      can :manage, Company, id: company.id
      can :read, Project if company.can_access_dashboard?
      can :show, Company
      cannot :index, Company
      cannot [:edit, :destroy, :create], Project
    elsif company.is_normal_company?
      can :manage, Project, company_id: company.id
      can :manage, Company, id: company.id
      can :read, Company
      cannot :index, Project
      cannot :index, Company unless company.can_access_dashboard?
    else
      can :create, Company
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
