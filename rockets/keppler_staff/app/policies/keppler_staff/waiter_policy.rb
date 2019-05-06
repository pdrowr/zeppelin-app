module KepplerStaff
  # Policy for Waiter model
  class WaiterPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end
  end
end