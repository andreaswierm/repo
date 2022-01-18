import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:repo/src/repo_mutation/repo_mutation.dart';
import 'package:repo/src/repo_query/repo_query.dart';

class Repo {
  T query<T>(
    RepoQuery<T> query,
  ) =>
      query.apply(this);

  T mutate<T>(RepoMutation<T> mutation) {
    return mutation.mutate(this);
  }

  static T read<T>(BuildContext context) {
    return context.read<T>();
  }

  static Widget provider<T>({
    required T Function(BuildContext) create,
    Widget? child,
    Widget Function(BuildContext, Widget?)? builder,
  }) {
    return Provider<T>(
      create: create,
      child: child,
      builder: builder,
    );
  }
}
