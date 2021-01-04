import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['cardElement', 'cardErrors'];

  connect() {
    if (!this.pageIsTurboPreview) {
      this.stripe = Stripe(this.publicKey);
      this.elements = this.stripe.elements();

      this.card = this.elements.create('card', { style: this.formStyles });
      this.card.mount(this.cardElementTarget);

      this.handleLiveErrors();
    }
  }

  handleLiveErrors() {
    this.card.on('change', (event) => {
      var displayError = this.cardErrorsTarget;
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });
  }

  async submitForm(e) {
    e.preventDefault();

    try {
      const token = await this.stripe.createToken(this.card);
      const pm = await this.stripe.createPaymentMethod({
        type: 'card',
        card: this.card,
      });

      this.stripeTokenHandler(token.token, pm.paymentMethod.id);
    } catch (e) {
      this.cardErrorsTarget.textContent = e.error.message;
    }

    // this.stripe.createToken(this.card).then((result) => {
    //   if (result.error) {
    //     this.cardErrorsTarget.textContent = result.error.message;
    //   } else {
    //     this.stripe
    //       .createPaymentMethod({
    //         type: 'card',
    //         card: this.card,
    //       })
    //       .then((pm) => {
    //         if (pm.error) {
    //           this.cardErrorsTarget.textContent = pm.error.message;
    //         } else {
    //           this.stripeTokenHandler(result.token, pm.paymentMethod.id);
    //         }
    //       });
    //   }
    // });
  }

  stripeTokenHandler(token, pm) {
    const hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripe_token');
    hiddenInput.setAttribute('value', token.id);
    this.element.appendChild(hiddenInput);

    const pmHiddenInput = document.createElement('input');
    pmHiddenInput.setAttribute('type', 'hidden');
    pmHiddenInput.setAttribute('name', 'pm_token');
    pmHiddenInput.setAttribute('value', pm);
    this.element.appendChild(pmHiddenInput);

    // Submit the form
    this.element.submit();
  }

  get publicKey() {
    return document.querySelector("meta[name='stripe-public-key']").content;
  }

  get formStyles() {
    return {
      base: {
        color: '#32325d',
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
        fontSmoothing: 'antialiased',
        fontSize: '16px',
        '::placeholder': {
          color: '#aab7c4',
        },
      },
      invalid: {
        color: '#fa755a',
        iconColor: '#fa755a',
      },
    };
  }
}
