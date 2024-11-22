import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class MockDatabase implements DatabaseRepository {
  final List<String> _items = [];

  @override
  Future<int> get itemCount async {
    await Future.delayed(const Duration(milliseconds: 20));
    return _items.length;
  }

  @override
  Future<List<String>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 20));
    return _items;
  }

  @override
  Future<void> addItem(String item) async {
    //make sure item doesn't exist yet and is not empty
    if (item.isNotEmpty && !_items.contains(item)) _items.add(item);
  }

  @override
  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    // make sure not empty and not same as other
    if (newItem.isNotEmpty && !_items.contains(newItem)) {
      _items[index] = newItem;
    }
  }
}
