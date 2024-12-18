part of 'scoring_result.dart';

class ScoringResultController extends ChangeNotifier {
  static String storageName = 'patients';

  final List<ScoringResult> _scoringResultItems = [];
  List<ScoringResult> get scoringResultItems => _scoringResultItems;

  CollectionReference scoringResults =
      FirebaseFirestore.instance.collection('scoring_results');

  // Future<List<ScoringResult>> initialization({String? idNumber}) async {
  //   return networkApiServices.getApiResponse(Core.url(prefix: 'patient/$idNumber/scoring-result')).then((value) async {
  //     _scoringResultItems = List.generate(value.length, (index) => ScoringResult.fromMap(value[index]));
  //     notifyListeners();
  //     return _scoringResultItems;
  //   }).onError((Handler error, stackTrace) {
  //     Utils.errorToast(message: error.message);
  //     return Future.error(error.message);
  //   });
  // }

  Future<ScoringResult> create(ScoringResult scoringResult) async {
    return scoringResults.add(scoringResult.toMap()).then((value) async {
      await value.update({'id': value.id});
      return await value.get().then((c) {
        print("${c.data()}");
        return ScoringResult.fromMap(c.data() as Map<String, dynamic>);
      });
    }).onError((Handler error, stackTrace) {
      Utils.errorToast(message: error.message);
      return Future.error(error.message);
    });
  }
}
