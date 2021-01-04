class App::SubscriptionsController < App::BaseController
  layout "stripe", only: :new

  def new; end
end
