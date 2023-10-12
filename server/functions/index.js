const { onRequest } = require('firebase-functions/v2/https');

const stripe = require('stripe')('secret key here');

const generateResponse = function (intent) {
  switch (intent.status) {
    case 'requires_confirmation':
    case 'requires_action':
      return {
        clientSecret: intent.client_secret,
        requiresAction: true,
        status: intent.status,
      };
    case 'requires_payment_method':
      return {
        error: 'Your card was denied, please provide a new payment method',
      };
    case 'succeeded':
      console.log('💰 Payment succeeded.');
      return {
        clientSecret: intent.client_secret,
        status: intent.status,
      };
  }
  return {
    error: 'Invalid PaymentIntent status',
  };
};

exports.StripePaymentIntentCreate = onRequest(async (req, res) => {
  const { paymentMethodId, amount, currency, useStripeSdk, metadata } =
    req.body;

  try {
    if (paymentMethodId) {
      const paymentIntent = await stripe.paymentIntents.create({
        amount: amount,
        currency: currency,
        payment_method: paymentMethodId,
        payment_method_types: ['card'],
        use_stripe_sdk: useStripeSdk,
        metadata: metadata,
      });
      console.log(paymentIntent);
      return res.send(generateResponse(paymentIntent));
    }
    return res.status(400).json({
      error: 'Please provide a paymentMethodId',
    });
  } catch (e) {
    return res.status(500).json({
      error: e.message,
    });
  }
});
