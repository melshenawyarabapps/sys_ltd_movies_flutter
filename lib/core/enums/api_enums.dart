enum RequestStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension RequestStatusExtension on RequestStatus? {
  bool get isLoading => this == RequestStatus.loading;
  bool get isLoaded => this == RequestStatus.loaded;
  bool get isError => this == RequestStatus.error;
  bool get isLoadingMore => this == RequestStatus.loadingMore;
}
