module KepplerClients
  # Policy for Client model
  class ClientPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end

    def create?
      false
    end
  end
end
