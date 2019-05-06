module KepplerStaff
  # Policy for Chef model
  class ChefPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end
  end
end