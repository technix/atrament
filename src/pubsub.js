class PubSub {
  constructor() {
    this.handlers = {};
  }

  subscribeAll(eventList) {
    Object.entries(eventList).forEach((event) => this.subscribe(...event));
  }

  subscribe(event, handler) {
    this.handlers[event] = handler;
  }

  apply(callback) {
    Object.entries(this.handlers).forEach(callback);
  }

  publish(event, args) {
    return this.handlers[event] ? this.handlers[event](args) : null;
  }
}

export default PubSub;
