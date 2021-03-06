class App::SubscriptionsController < App::BaseController
  layout "stripe"

  def new; end

  def create
    project = Project.find("528825e9-5e5d-4517-bcfc-56d7fb325813")

    customer =
      if project.stripe_customer_id?
        Stripe::Customer.retrieve(project.stripe_customer_id)
      else
        Stripe::Customer.create(
          source: params[:stripe_token],
          name: "Mama Ahmed",
          email: "mama@dad.com",
          description: "hello world",
          address: {
            city: "Hawaii",
            country: "United States",
            line1: "Hello world",
            postal_code: "232323",
            state: "Lousina"
          },
        )
      end

    subscription = Stripe::Subscription.create(
      customer: customer.id,
      plan: "price_1I5vshCYHrwDIsnf981UpZEc",
      expand: ["latest_invoice"],
    )

    project.update(
      subscription_params.merge({
        stripe_customer_id: customer.id,
        stripe_subscription_id: subscription.id
      }),
    )

    intent_id = subscription.latest_invoice.payment_intent

    if subscription.status == "active"
      redirect_to app_confirm_subscription_path(payment_intent: intent_id)
    else
      begin
        confirm_intent = Stripe::PaymentIntent.confirm(intent_id, {
          payment_method: params[:pm_token],
          return_url: app_confirm_subscription_url
        })

        if confirm_intent.next_action
          redirect_to confirm_intent.next_action.redirect_to_url.url
        else
          redirect_to app_confirm_subscription_path(payment_intent: intent_id)
        end
      rescue Stripe::CardError => e
        redirect_back fallback_location: root_path, alert: { message: e.error.message }
      end
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:card_brand, :card_exp_month, :card_exp_year, :card_last4)
  end
end
