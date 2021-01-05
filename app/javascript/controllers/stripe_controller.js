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
      const { token } = await this.stripe.createToken(this.card);
      const { paymentMethod } = await this.stripe.createPaymentMethod({
        type: 'card',
        card: this.card,
      });

      this.stripeTokenHandler(token, paymentMethod.id);
    } catch (e) {
      this.cardErrorsTarget.textContent = e.error.message;
    }
  }

  async stripeTokenHandler(token, paymentMethod) {
    const hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripe_token');
    hiddenInput.setAttribute('value', token.id);
    this.element.appendChild(hiddenInput);

    const pmHiddenInput = document.createElement('input');
    pmHiddenInput.setAttribute('type', 'hidden');
    pmHiddenInput.setAttribute('name', 'pm_token');
    pmHiddenInput.setAttribute('value', paymentMethod);
    this.element.appendChild(pmHiddenInput);

    this.element.submit();
  }

  get publicKey() {
    return document.querySelector("meta[name='stripe-public-key']").content;
  }

  get formStyles() {
    return {
      base: {
        color: '#24292e',
        fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI"',
        fontSmoothing: 'antialiased',
        fontSize: '14px',
        '::placeholder': {
          color: '#6a737d',
        },
      },
      invalid: {
        color: '#cb2431',
        iconColor: '#f97583',
      },
    };
  }
}
