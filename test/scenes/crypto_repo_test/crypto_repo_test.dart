import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repo/repo.dart';

class Coin {
  final int key;

  Coin({
    required this.key,
  });
}

class ListCoinsQuery implements RepoQuery<Future<List<Coin>>> {
  @override
  Future<List<Coin>> apply(CryptoRepo repo) async {
    return repo.collection;
  }
}

class AddCoinMutation implements RepoMutation<Future<void>> {
  final Coin coin;

  AddCoinMutation({
    required this.coin,
  });

  @override
  Future<void> mutate(CryptoRepo repo) async {
    repo.collection.add(coin);
  }
}

class CryptoRepo extends Repo {
  final List<Coin> collection;

  CryptoRepo({
    required this.collection,
  });

  static CryptoRepo of(BuildContext context) {
    return Repo.read<CryptoRepo>(context);
  }

  static Widget provider({
    required CryptoRepo Function(BuildContext) create,
    Widget? child,
    Widget Function(BuildContext, Widget?)? builder,
  }) {
    return Repo.provider<CryptoRepo>(
      create: create,
      child: child,
      builder: builder,
    );
  }
}

void main() {
  group("#query()", () {
    test('load no coins if the repo is empty', () async {
      final CryptoRepo cryptoRepo = CryptoRepo(collection: []);

      final coins = await cryptoRepo.query(
        ListCoinsQuery(),
      );

      expect(coins.length, 0);
    });

    test('load all coins from the repo', () async {
      final CryptoRepo cryptoRepo = CryptoRepo(
        collection: [
          Coin(key: 1),
          Coin(key: 2),
        ],
      );

      final coins = await cryptoRepo.query(
        ListCoinsQuery(),
      );

      expect(coins.length, 2);
    });
  });

  group("mutation()", () {
    test("adds a new coin to the collection", () async {
      final CryptoRepo cryptoRepo = CryptoRepo(
        collection: [
          Coin(key: 1),
          Coin(key: 2),
        ],
      );

      await cryptoRepo.mutate(AddCoinMutation(coin: Coin(key: 3)));

      expect(cryptoRepo.collection.length, 3);
      expect(cryptoRepo.collection.elementAt(0).key, 1);
      expect(cryptoRepo.collection.elementAt(1).key, 2);
      expect(cryptoRepo.collection.elementAt(2).key, 3);
    });
  });
}
