import 'dart:collection';
import 'dart:math';

import 'package:nary_tree/src/node.dart';

class Tree<T> {
  Node<T>? _root;

  bool get isEmpty => _root == null;
  bool get isNotEmpty => _root != null;

  int _maxDepth = 1;
  int get maximumDepth => _root != null ? _depth(_root!, 1) : -1;

  int get size => _root != null ? _root!.getNumberOfDescendants() + 1 : 0;

  Tree({Node<T>? root}) : _root = root;

  void setRoot(Node<T> root) => _root = root;

  bool nodeExists(Node<T> node, T data) {
    if (node.data == data) {
      return true;
    }

    for (var child in node.children) {
      if (nodeExists(child, data)) {
        return true;
      }
    }
    return false;
  }

  Node<T>? find(Node<T> node, T data) {
    if (node.data == data) {
      return node;
    }

    final Node<T>? temporaryNode = null;
    for (var child in node.children) {
      final temporaryNode = find(child, data);
      if (temporaryNode != null) {
        return temporaryNode;
      }
    }

    return temporaryNode;
  }

  List<Node<T>> preOrderTraversal() {
    final List<Node<T>> result = [];
    if (_root != null) {
      _preOrderTraversal(_root!, result);
    }

    return result;
  }

  List<Node<T>> postOrderTraversal() {
    final List<Node<T>> result = [];

    if (_root != null) {
      _postOrderTraversal(_root!, result);
    }

    return result;
  }

  List<Node<T>> inOrderTraversal() {
    return _root != null ? _inOrderTraversal(_root!) : [];
  }

  void _preOrderTraversal(Node<T> node, List<Node<T>> result) {
    result.add(node);
    for (var child in node.children) {
      _preOrderTraversal(child, result);
    }
  }

  void _postOrderTraversal(Node<T> node, List<Node<T>> result) {
    for (var child in node.children) {
      _postOrderTraversal(child, result);
    }
    result.add(node);
  }

  List<Node<T>> _inOrderTraversal(Node<T> node) {
    final List<Node<T>> result = [];

    final Queue<Node<T>> queue = Queue();
    queue.add(node);
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      result.add(current);

      for (var child in current.children) {
        queue.add(child);
      }
    }

    return result;
  }

  int _depth(Node<T> node, int depth) {
    int newDepth = depth + 1;
    final children = node.children;
    for (var child in children) {
      int maxCandidate = _depth(child, newDepth);
      _maxDepth = max(_maxDepth, maxCandidate);
    }

    return max(_maxDepth, depth);
  }
}
