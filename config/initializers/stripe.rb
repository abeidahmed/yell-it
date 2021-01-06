Stripe.api_key             = Rails.application.credentials.stripe.dig(:dev, :secret_key)
StripeEvent.signing_secret = Rails.application.credentials.stripe.dig(:dev, :signing_secret)

class PaymentSucceeded
  def call(event)
    object  = event.data.object
    project = Project.find(stripe_subscription_id: object.subscription)
    project.premium!
  end
end

StripeEvent.configure do |events|
  events.subscribe "invoice.payment_succeeded", PaymentSucceeded.new
end
