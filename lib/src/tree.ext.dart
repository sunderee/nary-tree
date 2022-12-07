import 'dart:collection';

import 'package:nary_tree/nary_tree.dart';

typedef TreeMap<T> = Map<T, List<T>>;

extension TreeExt<T> on Tree<T> {
  TreeMap<T> toMap() {
    final TreeMap<T> treeMap = {};

    final Queue<Node<T>> queue = Queue();
    if (rootNode == null) {
      return treeMap;
    }

    queue.add(rootNode!);
    while (queue.isNotEmpty) {
      final currentNode = queue.removeFirst();
      final children = <Node<T>>[];
      for (var child in currentNode.children) {
        children.add(child);
        queue.add(child);
      }

      treeMap[currentNode.data] = children.map((item) => item.data).toList();
    }

    return treeMap;
  }
}
