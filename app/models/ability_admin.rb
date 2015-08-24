class AbilityAdmin
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new # guest user (not logged in)
    puts '-'*50
    puts user.class.name
    puts '-'*50
    if user.class.name === 'AdminUser'
      can :manage, :all
    else
      can :read, :all
    end
  end
end
