import 'package:flutter/material.dart';
import '../../data/models/todo_item_model.dart';

class TodoBuilderWidget extends StatefulWidget {
  const TodoBuilderWidget({
    super.key,
    required this.initialItems,
    required this.onChanged,
    this.initialThreshold = 70,
  });

  final List<TodoItemModel> initialItems;
  final ValueChanged<List<TodoItemModel>> onChanged;
  final int initialThreshold;

  @override
  State<TodoBuilderWidget> createState() => _TodoBuilderWidgetState();
}

class _TodoBuilderWidgetState extends State<TodoBuilderWidget> {
  late List<TodoItemModel> _items;
  late int _threshold;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.initialItems);
    _threshold = widget.initialThreshold;
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Add checklist item...',
                  suffixIcon: Icon(Icons.add),
                ),
                onSubmitted: _addItem,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _addItem(_controller.text);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Completion Threshold: $_threshold%'),
        Slider(
          value: _threshold.toDouble(),
          min: 50,
          max: 100,
          divisions: 50,
          label: '$_threshold%',
          onChanged: (v) {
            setState(() => _threshold = v.toInt());
          },
        ),
        const SizedBox(height: 8),
        if (_items.isEmpty)
          const Text('No items added yet.')
        else
          ..._items.map(_buildItemRow),
      ],
    );
  }

  void _addItem(String title) {
    if (title.isEmpty) return;
    final newItem = TodoItemModel(
      id: UniqueKey().toString(),
      parentId: '',
      parentType: '',
      title: title,
      order: _items.length,
    );
    setState(() {
      _items.add(newItem);
      _controller.clear();
    });
    widget.onChanged(_items);
  }

  Widget _buildItemRow(TodoItemModel item) {
    return ListTile(
      key: ValueKey(item.id),
      leading: const Icon(Icons.drag_indicator),
      title: Text(item.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.note, size: 20),
            onPressed: () => _editNote(item),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () => _removeItem(item),
          ),
        ],
      ),
    );
  }

  void _editNote(TodoItemModel item) {
    _controller.text = item.note ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Note'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Add note...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final idx = _items.indexWhere((i) => i.id == item.id);
                _items[idx] = item.copyWith(note: _controller.text);
              });
              widget.onChanged(_items);
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _removeItem(TodoItemModel item) {
    setState(() {
      _items.removeWhere((i) => i.id == item.id);
    });
    widget.onChanged(_items);
  }
}