Rails.application.routes.draw do
  mount KepplerOrders::Engine => "/keppler_orders"
end
