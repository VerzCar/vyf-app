enum EventOperation {
  created,
  updated,
  deleted,
  repositioned,
}

EventOperation eventOperationFromEvent(String operation) {
  switch (operation) {
    case 'CREATED':
      return EventOperation.created;
    case 'UPDATED':
      return EventOperation.updated;
    case 'DELETED':
      return EventOperation.deleted;
    case 'REPOSITIONED':
      return EventOperation.repositioned;
    default:
      throw Exception('casting of event operation failed');
  }
}
