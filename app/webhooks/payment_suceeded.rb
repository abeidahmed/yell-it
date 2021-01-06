# class PaymentSucceeded
#   def call(event)
#     object  = event.data.object
#     project = Project.find(stripe_subscription_id: object.subscription)
#     project.premium!
#   end
# end
