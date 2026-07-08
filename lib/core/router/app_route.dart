enum AppRoute {
  home('/home'),
  record('/record'),
  brandRecord('/record/brand'),
  cafeRecord('/record/cafe'),
  homemadeRecord('/record/homemade'),
  journal('/journal'),
  profile('/profile');

  const AppRoute(this.path);

  final String path;
}
