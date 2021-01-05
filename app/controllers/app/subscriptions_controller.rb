class App::SubscriptionsController < App::BaseController
  layout "stripe"

  def new; end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripe_token],
      plan: "price_1I5vshCYHrwDIsnf981UpZEc",
      name: "Abeid Ahmed",
      email: "abeidahmed92@gmail.com",
      description: "hello world",
      address: {
        city: "Hawaii",
        country: "United States",
        line1: "Hello world",
        postal_code: "232323",
        state: "Lousina"
      },
    )

    intent = Stripe::PaymentIntent.create(
      amount: 2900,
      currency: "usd",
      customer: customer.id,
      description: "hello world",
      payment_method_types: ["card"],
    )

    confirm_intent = Stripe::PaymentIntent.confirm(intent.id, {
      payment_method: params[:pm_token],
      return_url: app_confirm_subscription_url
    })

    redirect_to confirm_intent.next_action.redirect_to_url.url if confirm_intent.next_action
  end
end
