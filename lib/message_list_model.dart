import 'package:flutter/material.dart';

class MessageListModel<E> {
  MessageListModel({@required this.listKey, Iterable<E> initialItems})
      : assert(listKey != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  int get length => _items.length;
  List<E> get items => _items;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}
