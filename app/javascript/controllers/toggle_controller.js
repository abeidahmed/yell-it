import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['toggleable'];
  static values = {
    attribute: String,
  };

  toggle() {
    this.toggleableTargets.forEach((element) => {
      element.toggleAttribute(this.attributeValue);
    });
  }
}
