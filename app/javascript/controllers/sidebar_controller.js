import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['toggleable'];

  toggle() {
    this.toggleableTargets.forEach((target) => {
      target.toggleAttribute('hidden');
    });
  }
}
