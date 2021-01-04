import { Controller } from 'stimulus';
import { formErrorHandler } from '../utils';

export default class extends Controller {
  static targets = ['showError'];

  async onError(e) {
    const formData = await e.detail.formSubmission;
    const { success, fetchResponse } = formData.result;

    if (!success) {
      const res = await fetchResponse.responseText;
      const { errors } = JSON.parse(res);

      this.showErrorTargets.forEach((errorTarget) => {
        const errorType = errorTarget.getAttribute('data-form-error');

        const errorMsg = formErrorHandler({
          errors,
          type: errorType,
        });
        errorTarget.innerHTML = errorMsg || '';
      });
    }
  }
}
