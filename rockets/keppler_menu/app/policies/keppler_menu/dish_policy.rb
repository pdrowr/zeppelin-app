module KepplerMenu
  # Policy for Dish model
  class DishPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end

    def create?
      false
    end

    def destroy?
      false
    end

    def clone?
      false
    end

    def update?
      false
    end
  end
end
