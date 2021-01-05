class App::Subscriptions::ConfirmSubscriptionsController < App::SubscriptionsController
  def show
    intent = Stripe::PaymentIntent.retrieve(params[:payment_intent])

    # rubocop:disable Style/GuardClause
    if intent.status == "requires_payment_method"
      redirect_to new_app_project_subscription_path("project_id"), alert:
      {
        message: "Payment failed. Please use another card."
      }
    end
    # rubocop:enable Style/GuardClause
  end
end
