# Repo Scaffold

This project aims to give a simple interface to create repositories that can be used with n number of queries and mutations

## How to use

Create your first first repo
```dart
class ExampleRepo extends Repo {
  final List<int> numbers;
}
```

Create a query
```dart
class ListAllNumbersQuery implements RepoQuery<Future<List<int>>> {

}
```
