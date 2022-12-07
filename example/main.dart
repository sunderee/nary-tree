import 'package:nary_tree/nary_tree.dart';

void main() {
  // Here's an example on how to create a tree
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

  // Some methods of adding children...
  root.children.first.addChild(Node<int>(data: 7));
  root.children.last.addChildren([
    Node<int>(data: 8),
    Node<int>(data: 9),
  ]);
  root.addChildAt(Node<int>(data: 10), 0);

  // ...some methods for removing them...
  root.removeChild(Node<int>(data: 10));

  // ...some methods for finding them...
  tree.nodeExists(tree.rootNode!, 8);

  // ...some methods for traversal
  print(tree.preOrderTraversal(tree.rootNode!).map((e) => e.data));
  print(tree.postOrderTraversal(tree.rootNode!).map((e) => e.data));
  print(tree.inOrderTraversal(tree.rootNode!).map((e) => e.data));

  // ...and lastly, an extension to turn it into a map
  print(tree.toMap());
}
