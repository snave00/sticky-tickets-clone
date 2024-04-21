class RouterConst {
  RouterConst._();

  /// Top Level Routes should start with [/].
  /// Sub Level Routes should not begin with [/].
  /// When calling [context.go] you must define the whole path.
  /// Example: [context.go('/' + RouterConstants.loginPagePath);].
  /// Given RouterConstants.loginPagePath = 'login'.
  /// Alternatively, you can use namedRoutes
  ///

  // * Query Params
  // used for root to determine if from manual login or auto login
  static const shellOrigin = 'shell-origin';

  // used for viewing event detail based on event id
  static const eventId = 'event-id';
}

enum Pages {
  initial(routePath: '/', routeName: 'initial'),

  events(routePath: 'events', routeName: 'events'),
  scanOperator(routePath: 'scanOperator', routeName: 'scanOperator'),
  eventDetail(routePath: 'eventDetail', routeName: 'eventDetail'),

  // bottom nav
  home(routePath: '/home', routeName: 'home'),
  activity(routePath: '/activity', routeName: 'activity'),
  cart(routePath: '/cart', routeName: 'cart'),
  account(routePath: '/account', routeName: 'account');

  const Pages({
    required this.routePath,
    required this.routeName, // named route
  });
  final String routePath;
  final String routeName;
}
