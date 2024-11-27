extension ListGetter<T> on List<T> {
  T? getOrNull(int index) {
    try {
      return this[index];
    } catch (e) {
      return null;
    }
  }
}

extension ReplaceAllItems<T> on List<T> {
  void replaceAllItems(List<T> replacements) {
    replaceRange(0, length, replacements);
  }

  void replaceAllItem(T replacement) {
    replaceRange(0, length, [replacement]);
  }
}
