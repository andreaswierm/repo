# Repo Scaffold

This project aims to give a simple interface to create repositories that can be used with n number of queries and mutations

## How to use

Create your first first repo
```dart
class ExampleRepo extends Repo {
  final List<int> numbers;
}
```

### Query
Create a query
```dart
class ListAllNumbersQuery implements RepoQuery<Future<List<int>>> {
  @override
  Future<List<int>> query(ExampleRepo repo) async {
    return repo.numbers;
  }
}
```

Use query
```dart
final numbers = await ExampleRepo.query(
  ListAllNumbersQuery(),
);
```


### Mutation
Create mutation
```dart
class AddItemMutation implements RepoMutation<Future<void>> {
  final int item;

  AddItemMutation({
    required this.item,
  });

  @override
  Future<void> mutate(ExampleRepo repo) async {
    repo.numbers.add(item);
  }
}
```

Use mutation
```dart
await ExampleRepo.mutate(
  AddItemMutation(
    item: 5,
  ),
);
```
