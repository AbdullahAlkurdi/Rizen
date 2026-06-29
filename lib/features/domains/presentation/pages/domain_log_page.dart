import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../todo/data/models/todo_item_model.dart';
import '../../../todo/data/models/todo_list_model.dart';
import '../../../todo/domain/usecases/save_todo_list_usecase.dart';
import '../../../todo/presentation/widgets/todo_checklist_widget.dart';
import '../cubit/domain_logs_cubit.dart';
import '../../data/domain_catalog.dart';

class _TodoPreviewWidget extends StatefulWidget {
  const _TodoPreviewWidget({
    required this.initialItems,
    required this.onChanged,
  });

  final List<TodoItemModel> initialItems;
  final ValueChanged<List<TodoItemModel>> onChanged;

  @override
  State<_TodoPreviewWidget> createState() => _TodoPreviewWidgetState();
}

class _TodoPreviewWidgetState extends State<_TodoPreviewWidget> {
  late List<TodoItemModel> _items;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.initialItems);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _removeItem(TodoItemModel item) {
    setState(() {
      _items.removeWhere((i) => i.id == item.id);
    });
    widget.onChanged(_items);
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
        const SizedBox(height: 8),
        if (_items.isEmpty)
          const Text('No checklist items.')
        else
          ..._items.map(
            (item) => ListTile(
              key: ValueKey(item.id),
              dense: true,
              title: Text(item.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete, size: 20),
                onPressed: () => _removeItem(item),
              ),
            ),
          ),
      ],
    );
  }
}

class DomainLogPage extends StatefulWidget {
  final String domainId;

  const DomainLogPage({super.key, required this.domainId});

  @override
  State<DomainLogPage> createState() => _DomainLogPageState();
}

class _DomainLogPageState extends State<DomainLogPage> {
  final _durationController = TextEditingController();
  final _metricController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isLoading = false;
  bool _hasTodoList = true;
  List<TodoItemModel> _todoItems = [];
  String? _savedLogId;

  @override
  void dispose() {
    _durationController.dispose();
    _metricController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveLog(DomainInfo domain) async {
    final duration = int.tryParse(_durationController.text) ?? 0;
    final metric = num.tryParse(_metricController.text) ?? 0;

    if (duration <= 0 && metric <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter duration or metric value')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final saveTodoList = context.read<SaveTodoListUseCase>();
    try {
      final logId = await context.read<DomainLogsCubit>().addLog(
        domainId: domain.routeId,
        duration: duration,
        notes: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        metricLabel: domain.metricLabel,
        metricValue: metric.toDouble(),
      );

      if (_hasTodoList && _todoItems.isNotEmpty) {
        try {
          final todoList = TodoListModel(
            id: logId,
            parentId: logId,
            parentType: 'domain_log',
            items: _todoItems
                .map((item) => item.copyWith(
                      parentId: logId,
                      parentType: 'domain_log',
                    ))
                .toList(),
            completionThreshold: 70,
          );
          await saveTodoList(todoList);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error saving todos: $e')),
            );
          }
        }
      }

      setState(() {
        _savedLogId = logId;
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${domain.name} session logged!')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final domain = DomainCatalog.byId(widget.domainId);

    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Log ${domain.name}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(PhosphorIconsBold.microphone),
        label: const Text('Voice Log'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _durationController,
            decoration: InputDecoration(
              labelText: 'Duration (Minutes)',
              hintText: 'e.g. 60',
              prefixIcon: const Icon(PhosphorIconsBold.clock),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _metricController,
            decoration: InputDecoration(
              labelText: domain.metricLabel,
              hintText: 'e.g. 10',
              prefixIcon: const Icon(PhosphorIconsBold.chartBar),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Notes',
              hintText: 'How did the session go?',
              prefixIcon: const Icon(PhosphorIconsBold.notepad),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Enable Session Checklist'),
            subtitle: const Text('Track sub-tasks for this session'),
            value: _hasTodoList,
            onChanged: (value) {
              setState(() => _hasTodoList = value);
            },
          ),
          if (_hasTodoList) ...[
            const SizedBox(height: 16),
            if (_savedLogId != null)
              TodoChecklistWidget(
                parentId: _savedLogId!,
                parentType: 'domain_log',
              )
            else
              _TodoPreviewWidget(
                initialItems: _todoItems,
                onChanged: (items) {
                  setState(() => _todoItems = items);
                },
              ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.glassFill,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsBold.star, color: domain.color, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Intensity: Normal',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Adjust')),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _isLoading
              ? const Column(
                  children: [
                    SkeletonListTile(),
                    SkeletonListTile(),
                    SkeletonListTile(),
                  ],
                )
              : RizenButton(
                  label: 'Save Entry',
                  icon: PhosphorIconsBold.check,
                  onPressed: () => _saveLog(domain),
                ),
        ],
      ),
    );
  }
}
