enum AppRoute {
  home('/home'),
  record('/record'),
  brandRecord('/record/brand'),
  cafeRecord('/record/cafe'),
  homemadeRecord('/record/homemade'),
  journal('/journal'),
  profile('/profile'),
  profileInfo('/profile/info'),
  profileLanguage('/profile/language'),
  profileWidgets('/profile/widgets'),
  profilePrivacy('/profile/privacy'),
  profilePrivacyPolicy('/profile/privacy/policy'),
  profileTerms('/profile/privacy/terms'),
  profileAbout('/profile/about');

  const AppRoute(this.path);

  final String path;
}
