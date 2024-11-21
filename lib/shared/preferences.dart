import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferences prefs;

  SharedPreferencesRepository(this.prefs);

  static const String _itemsKey = 'items';

  @override
  Future<int> get itemCount async {
    final items = await getItems();
    return items.length;
  }

  @override
  Future<List<String>> getItems() async {
    return prefs.getStringList(_itemsKey) ?? [];
  }

  @override
  Future<void> addItem(String item) async {
    final items = await getItems();
    if (!items.contains(item)) {
      items.add(item);
      await prefs.setStringList(_itemsKey, items);
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await getItems();
    items.removeAt(index);
    await prefs.setStringList(_itemsKey, items);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final items = await getItems();
    if (newItem.isNotEmpty && !items.contains(newItem)) {
      items[index] = newItem;
      await prefs.setStringList(_itemsKey, items);
    }
  }
}
