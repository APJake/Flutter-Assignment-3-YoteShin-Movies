import 'package:get/get.dart';

import '../models/collection_detail.dart';
import '../networks/api.dart';

class CollectionController extends GetxController {
  Rxn<CollectionDetail> detail = Rxn<CollectionDetail>();
  final API api = API();

  loadCollectionDetail(collectionId) {
    api.getCollectionDetail(collectionId).then((value) {
      detail.value = value;
    });
  }
}
