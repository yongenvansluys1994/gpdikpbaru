import 'package:get/get.dart';
import 'package:gpdikpbaru/common/api.dart';
import 'package:gpdikpbaru/models/model_datarenungan.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Renungan_Controller extends GetxController {
  final _page = 1.obs;
  final _items = <ModeldataRenungan>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = false.obs;
  final _hasReachedMax = false.obs;

  Renungan_Controller();

  int get page => _page.value;
  int get count => _items.length;
  List<ModeldataRenungan> get items => _items.toList();

  bool get isFirstPage => page == 1;
  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingFirst => isLoading && isFirstPage;
  bool get isLoadingMore => isLoading && page > 1;
  bool get hasReachedMax => _hasReachedMax.value;

  ModeldataRenungan item(int index) => _items[index];

  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  Future<void> _init() async {
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    await loadPerPage();
    trigger();
  }

  Future<void> refresh() async {
    _page.value = 1;
    _items.clear();
    await loadPerPage();
  }

  Future<void> refresh2() async {
    _page.value = 1;
    _items.clear();
    await loadPerPage();
  }

  Future<void> loadPerPage() async {
    if (!isLoading) {
      _isLoading.value = true;

      final items = await ApiAuth.datarenungan(page);

      if (items == null) {
        if (isFirstPage) {
          _isFailed.value = true;
        }
      } else {
        if (items.isEmpty) {
          if (isFirstPage) {
            _isEmpty.value = true;
          } else {
            _hasReachedMax.value = true;
          }
        } else {
          _items.addAll(items);
          _page.value = _page.value + 1;

          _isEmpty.value = false;
          _hasReachedMax.value = false;
        }

        _isFailed.value = false;
      }

      _isLoading.value = false;
    }
  }

  void scrollToTop() {
    itemScrollController.scrollTo(
      index: 0,
      duration: Duration(milliseconds: 300),
    );
  }

  void trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        loadPerPage();
      }
    });
  }
}
