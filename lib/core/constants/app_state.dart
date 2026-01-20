enum AppState { initial, loading, loaded, error }

extension AppStateX on AppState {
  bool get isInitial => this == AppState.initial;
  bool get isLoading => this == AppState.loading;
  bool get isLoaded => this == AppState.loaded;
  bool get isError => this == AppState.error;
}
