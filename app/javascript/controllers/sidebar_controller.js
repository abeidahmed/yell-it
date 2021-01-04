import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['aside'];

  toggle() {
    this.asideTarget.classList.toggle('Sidebar--active');
  }
}
