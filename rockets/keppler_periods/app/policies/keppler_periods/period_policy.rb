module KepplerPeriods
  # Policy for Period model
  class PeriodPolicy < ControllerPolicy
    def create?
      @objects.where(open: true).blank?
    end
  end
end
