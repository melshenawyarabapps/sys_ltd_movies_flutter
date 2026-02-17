enum MoviesEventType { fetch, loadMore }

class MoviesEvent {
  final MoviesEventType type;

  const MoviesEvent._(this.type);

  const MoviesEvent.fetch() : this._(MoviesEventType.fetch);
  const MoviesEvent.loadMore() : this._(MoviesEventType.loadMore);
}
