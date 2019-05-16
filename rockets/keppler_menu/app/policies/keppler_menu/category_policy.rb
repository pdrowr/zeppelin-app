module KepplerMenu
  # Policy for Category model
  class CategoryPolicy < ControllerPolicy
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
