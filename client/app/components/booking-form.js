import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import { inject as service } from '@ember/service';
import mutation from '../gql/mutations/create-booking.graphql';

export default class BookingFormComponent extends Component {
  @service apollo;

  @tracked firstName = '';
  @tracked lastName = '';

  @action
  updateField(field, event) {
    this[field] = event.target.value;
  }

  @action
  async submitBooking(event) {
    event.preventDefault();

    try {
      const variables = {
        eventId: this.args.eventId, // Pass event ID from parent
        firstName: this.firstName,
        lastName: this.lastName,
      };

      let response = await this.apollo.mutate({ mutation, variables });

      alert(
        `Booking created for name: ${response.createBooking.firstName} ${response.createBooking.lastName}!`,
      );

      window.location.reload(true);
    } catch (error) {
      console.error('Error creating booking:', error);
      alert('Failed to create booking. Please try again.');
    }
  }
}
