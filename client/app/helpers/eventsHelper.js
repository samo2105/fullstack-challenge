export function groupEventsByDay(events) {
    return events.reduce((acc, event) => {
      let date = new Date(event.start).toISOString().split('T')[0];
      if (!acc[date]) {
        acc[date] = [];
      }
      acc[date].push(event);
      return acc;
    }, {});
}