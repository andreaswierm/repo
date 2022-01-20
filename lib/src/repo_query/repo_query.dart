import 'package:repo_scaffold/src/repo/repo.dart';

abstract class RepoQuery<T extends dynamic> {
  T query(covariant Repo repo);
}
