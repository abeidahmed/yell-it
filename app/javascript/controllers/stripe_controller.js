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
    const { id, card } = token;
    const inputTypes = [
      {
        name: 'stripe_token',
        value: id,
      },
      {
        name: 'pm_token',
        value: paymentMethod,
      },
      {
        name: 'subscription[card_brand]',
        value: card.brand,
      },
      {
        name: 'subscription[card_exp_month]',
        value: card.exp_month,
      },
      {
        name: 'subscription[card_exp_year]',
        value: card.exp_year,
      },
      {
        name: 'subscription[card_last4]',
        value: card.last4,
      },
    ];

    inputTypes.forEach((inputType) => {
      const { name, value } = inputType;
      appendHiddenElement(this.element, name, value);
    });

    // console.log(token);
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

function appendHiddenElement(element, name, value) {
  const hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', name);
  hiddenInput.setAttribute('value', value);
  element.appendChild(hiddenInput);
}
