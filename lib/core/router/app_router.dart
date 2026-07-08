import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import '../../features/journal/presentation/journal_page.dart';
import '../../features/profile/presentation/profile_page.dart';
import '../../features/record/domain/coffee_record.dart';
import '../../features/record/presentation/record_detail_page.dart';
import '../../features/record/presentation/record_source_page.dart';
import 'app_route.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.home.path,
    routes: [
      GoRoute(path: '/', redirect: (context, state) => AppRoute.home.path),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: AppShell(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.journal.path,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: JournalPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.record.path,
        pageBuilder: (context, state) =>
            _recordFlowPage(state, const RecordSourcePage()),
      ),
      GoRoute(
        path: AppRoute.brandRecord.path,
        pageBuilder: (context, state) => _recordFlowPage(
          state,
          RecordDetailPage(
            sourceType: CoffeeSourceType.brand,
            editId: state.uri.queryParameters['editId'],
          ),
        ),
      ),
      GoRoute(
        path: AppRoute.cafeRecord.path,
        pageBuilder: (context, state) => _recordFlowPage(
          state,
          RecordDetailPage(
            sourceType: CoffeeSourceType.cafe,
            editId: state.uri.queryParameters['editId'],
          ),
        ),
      ),
      GoRoute(
        path: AppRoute.homemadeRecord.path,
        pageBuilder: (context, state) => _recordFlowPage(
          state,
          RecordDetailPage(
            sourceType: CoffeeSourceType.homemade,
            editId: state.uri.queryParameters['editId'],
          ),
        ),
      ),
    ],
  );
});

CustomTransitionPage<void> _recordFlowPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}
