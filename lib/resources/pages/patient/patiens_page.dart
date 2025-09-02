import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class PatientArguments {
  final bool isHistory;
  PatientArguments({required this.isHistory});
}

class PatientPage extends StatefulWidget {
  final bool isHistory;
  const PatientPage({super.key, required this.isHistory});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

// add BindingObserver to the page

class _PatientPageState extends State<PatientPage> {
  User? user = FirebaseAuth.instance.currentUser;

  List<QueryDocumentSnapshot> _allDocuments = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  final int _limit = 7;
  late Stream<List<QueryDocumentSnapshot>> _patientStream;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _patientStream = _getInitialPatients();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void deactivate() {
    _scrollController.removeListener(_scrollListener);
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Stream<List<QueryDocumentSnapshot>> _getInitialPatients() async* {
    final initialQuery =
        widget.isHistory
            ? PatientController().patients.where('user_id', isEqualTo: user!.uid).limit(_limit)
            : PatientController().patients.orderBy('created_at').limit(_limit);

    final snap = await initialQuery.get();
    _lastDocument = snap.docs.isNotEmpty ? snap.docs.last : null;
    _allDocuments = snap.docs;
    yield snap.docs;
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _lastDocument == null) return;

    try {
      final newQuery =
          widget.isHistory
              ? PatientController().patients.where('user_id', isEqualTo: user!.uid).startAfterDocument(_lastDocument!).limit(_limit)
              : PatientController().patients.orderBy('created_at').startAfterDocument(_lastDocument!).limit(_limit);

      final snap = await newQuery.get();
      if (snap.docs.isEmpty) {
        setState(() => _hasMore = false);
        return;
      }

      debugPrint('Initial docs loaded: ${_allDocuments.length}');
      debugPrint('Loading more from: ${_lastDocument?.id}');
      debugPrint('New docs loaded: ${snap.docs.length}');

      setState(() {
        _lastDocument = snap.docs.last;
        _allDocuments.addAll(snap.docs);
      });
    } catch (e) {
      debugPrint('Load more error: $e');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && _hasMore) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cAppBar(
        title: widget.isHistory ? 'screeningData'.tr : 'patientData'.tr,
        centerTitle: true,
        leading: GestureDetector(onTap: () => Get.back(), child: Icon(MdiIcons.chevronLeft, size: 20)),
      ),
      body: Stack(
        children: [
          Positioned(
            left: -1,
            right: -2,
            bottom: 0,
            child: CustomPaint(size: Size(context.width, context.height / 1.9), painter: RPSCustomPainter1()),
          ),
          Positioned(
            left: -2,
            right: -2,
            bottom: -2,
            child: CustomPaint(size: Size(context.width, context.height / 2.0), painter: RPSCustomPainter2()),
          ),
          RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _hasMore = true;
                _lastDocument = null;
                _allDocuments.clear();
                _patientStream = _getInitialPatients();
              });
            },
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: _patientStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Terjadi kesalahan, silahkan coba lagi",
                        style: context.textTheme.bodyLarge!.copyWith(color: Colors.blue[900], fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) return Center(child: cLoading());
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Belum ada data pemeriksaan",
                        style: context.textTheme.bodyLarge!.copyWith(color: Colors.blue[900], fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  // Data available, display ListView
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: _allDocuments.length + (_hasMore && _allDocuments.length >= _limit ? 1 : 0), // <-- Perubahan disini
                    itemBuilder: (context, index) {
                      // Tampilkan loading hanya jika data mencapai limit
                      if (_hasMore && _allDocuments.length >= _limit && index >= _allDocuments.length) {
                        return Center(child: Padding(padding: const EdgeInsets.all(16.0), child: CircularProgressIndicator()));
                      }

                      // Pastikan index valid
                      if (index < 0 || index >= _allDocuments.length) {
                        return SizedBox.shrink();
                      }

                      // Tampilkan data pasien
                      final patientData = _allDocuments[index].data() as Map<String, dynamic>;
                      return patientCard(
                        context,
                        patient: Patient.fromMap({
                          'user_id': patientData['user_id'] ?? '',
                          'diagnostic': patientData['diagnostic'] ?? 'Kosong',
                          ...patientData,
                        }),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
