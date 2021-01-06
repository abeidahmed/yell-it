Stripe.api_key             = Rails.application.credentials.stripe.dig(:dev, :secret_key)
StripeEvent.signing_secret = Rails.application.credentials.stripe.dig(:dev, :signing_secret)

StripeEvent.configure do |events|
  events.subscribe "invoice.payment_succeeded", PaymentSucceeded.new
end
