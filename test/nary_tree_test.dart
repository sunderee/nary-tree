import 'package:nary_tree/src/node.dart';
import 'package:nary_tree/src/tree.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

/// This file might get pretty big, so to summarize what I'm trying to test,
/// here's a list of key things I'm testing:
///
/// 1. Whether the tree is able to correctly store and retrieve data for nodes
/// at different depths.
/// 2. Whether the tree is able to correctly handle insertion and deletion of
/// nodes at different depths.
/// 3. Whether the tree is able to correctly handle searching for specific nodes
/// based on its data.
/// 4. Whether the tree is able to correctly handle traversals, in particular,
/// pre-order, post-order, and in-order traversals.
void main() {
  final root = Node<int>(data: 1);
  root.addChildren([
    Node<int>(data: 3)
      ..addChildren([
        Node<int>(data: 5),
        Node<int>(data: 6),
      ]),
    Node<int>(data: 2),
    Node<int>(data: 4),
  ]);

  final tree = Tree<int>();
  tree.setRoot(root);

  group('insert/retrieve', () {
    test('order of children', () {
      final testNode = Node<int>(data: 1);
      testNode.addChild(Node<int>(data: 2));
      testNode.addChildren([Node<int>(data: 3), Node<int>(data: 4)]);
      testNode.addChildAt(Node<int>(data: 5), 0);

      expect(testNode.data, 1);
      expect(testNode.children.length, 4);
      expect(
        testNode.children.map((child) => child.data),
        [5, 2, 3, 4],
      );
    });

    test('setting parent', () {
      final testNode = Node<int>(data: 1);
      testNode.addChild(Node<int>(data: 2));
      testNode.addChildren([Node<int>(data: 3), Node<int>(data: 4)]);
      testNode.addChildAt(Node<int>(data: 5), 0);

      expect(
        testNode.children.every((child) => child.parent?.data == testNode.data),
        true,
      );
    });
  });

  group('insert/remove', () {
    test('remove by value', () {
      final testNode = Node<int>(data: 1);
      testNode.addChild(Node<int>(data: 2));
      testNode.addChildren([Node<int>(data: 3), Node<int>(data: 4)]);
      testNode.addChildAt(Node<int>(data: 5), 0);
      testNode.removeChild(Node<int>(data: 3));

      expect(testNode.children.length, 3);
      expect(
        testNode.children.map((child) => child.data),
        [5, 2, 4],
      );
    });

    test('remove by index', () {
      final testNode = Node<int>(data: 1);
      testNode.addChild(Node<int>(data: 2));
      testNode.addChildren([Node<int>(data: 3), Node<int>(data: 4)]);
      testNode.addChildAt(Node<int>(data: 5), 0);
      testNode.removeChildAt(1);

      expect(testNode.children.length, 3);
      expect(
        testNode.children.map((child) => child.data),
        [5, 3, 4],
      );
    });

    test('remove all', () {
      final testNode = Node<int>(data: 1);
      testNode.addChild(Node<int>(data: 2));
      testNode.addChildren([Node<int>(data: 3), Node<int>(data: 4)]);
      testNode.addChildAt(Node<int>(data: 5), 0);
      testNode.removeChildren();

      expect(testNode.children.isEmpty, true);
    });
  });

  group('searching', () {
    test('find node', () {
      final result = tree.find(root, 4);
      expect(result != null, true);
    });

    test('non-existent node', () {
      final result = tree.find(root, 7);
      expect(result == null, true);
    });

    test('check node existence', () {
      expect(tree.nodeExists(root, 2), true);
    });
  });

  group('traversal', () {
    test('pre-order traversal', () {
      final result = tree.preOrderTraversal();
      expect(
        result.map((item) => item.data),
        [1, 3, 5, 6, 2, 4],
      );
    });

    test('post-order traversal', () {
      final result = tree.postOrderTraversal();
      expect(
        result.map((item) => item.data),
        [5, 6, 3, 2, 4, 1],
      );
    });

    test('in-order traversal', () {
      final result = tree.inOrderTraversal();
      expect(
        result.map((item) => item.data),
        [1, 3, 2, 4, 5, 6],
      );
    });
  });

  test('max size', () => expect(tree.maximumDepth, 3));
}
