class App::SubscriptionsController < App::BaseController
  layout "stripe"

  def new; end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripe_token],
      plan: "price_1I5vshCYHrwDIsnf981UpZEc",
      name: "John Doe",
      email: "company@example.com",
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
      payment_method_options: {
        card: {
          request_three_d_secure: "any"
        }
      },
    )

    Stripe::PaymentIntent.confirm(intent.id, {
      payment_method: params[:pm_token]
    })

    # raise intent
  end
end
