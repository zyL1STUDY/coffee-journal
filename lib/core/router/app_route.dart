enum AppRoute {
  home('/home'),
  journal('/journal'),
  profile('/profile');

  const AppRoute(this.path);

  final String path;
}
