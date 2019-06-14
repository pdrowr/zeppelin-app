module KepplerPeriods
  # Policy for Period model
  class PeriodPolicy < ControllerPolicy
    def create?
      @objects.where(open: true).blank?
    end

    def update?
      @objects.where(open: true).blank?
    end

    def clone?
      @objects.where(open: true).blank?
    end    
  end
end
