KepplerOrders::Engine.routes.draw do
  namespace :admin do
    scope :orders, as: :orders do
    end
  end
end
