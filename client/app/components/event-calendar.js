import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

import FullCalendar from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

export default class EventCalendarComponent extends Component {
  @tracked calendar = null;

  @action
  setupCalendar(element) {
    const events = this.args.events.map(event => ({
      id: event.id,
      title: event.title,
      start: event.start,
      extendedProps: {
        bookings: event.bookings || [] 
      }
    }));

    // Initialize FullCalendar
    this.calendar = new FullCalendar.Calendar(element, {
      plugins: [dayGridPlugin, interactionPlugin],
      initialView: 'dayGrid',
      events: events,
      eventClick: this.onEventClick
    });

    this.calendar.render();
  }

  @action
  onEventClick(info) {
    alert(`Event: ${info.event.title}`);
  }
}