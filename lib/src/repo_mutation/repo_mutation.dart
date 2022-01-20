import 'package:repo_scaffold/src/repo/repo.dart';

abstract class RepoMutation<T extends dynamic> {
  T mutate(covariant Repo repo);
}
