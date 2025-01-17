# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? # 检查是否有登入
      can :manage, Liste, user_id: user.id # user_id: user.id：用户仅能管理自己所有的
      can :manage, Todo, user_id: user.id
    end
  end
end
