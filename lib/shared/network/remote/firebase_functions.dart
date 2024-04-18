import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/watchlist_model.dart';

class FirebaseFunctions {
  static CollectionReference<WatchListModel> getWatchListCollection() {
    return FirebaseFirestore.instance
        .collection("WatchList")
        .withConverter<WatchListModel>(
      fromFirestore: (snapshot, _) {
        return WatchListModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static void addToWatchList(WatchListModel model) {
    var collection = getWatchListCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    docRef.set(model);
  }

  static Future<QuerySnapshot<WatchListModel>> getMovie() {
    return getWatchListCollection().get();
  }

  static Future<void> removeFromWatchList(WatchListModel id) async {
    var collection = getWatchListCollection();
    await collection.doc().delete();
  }
}
