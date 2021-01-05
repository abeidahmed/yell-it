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

    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [
        { price: "price_1I5vshCYHrwDIsnf981UpZEc" },
      ],
      expand: ["latest_invoice"]
    })

    intent_id = subscription.latest_invoice.payment_intent
    return redirect_to app_confirm_subscription_path(payment_intent: intent_id) if subscription.status == "active"

    confirm_intent = Stripe::PaymentIntent.confirm(intent_id, {
      payment_method: params[:pm_token],
      return_url: app_confirm_subscription_url
    })

    redirect_to confirm_intent.next_action.redirect_to_url.url

    # if confirm_intent.next_action
    #   redirect_to confirm_intent.next_action.redirect_to_url.url
    # else
    #   redirect_to app_confirm_subscription_path(payment_intent: confirm_intent.id)
    # end
  end
end
