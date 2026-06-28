import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../todo/data/models/todo_item_model.dart';
import '../../../todo/data/models/todo_list_model.dart';
import '../../../todo/domain/usecases/save_todo_list_usecase.dart';
import '../../../todo/presentation/widgets/todo_checklist_widget.dart';
import '../../data/models/habit_model.dart';
import '../cubit/habits_cubit.dart';

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

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key, this.habitId});

  final String? habitId;

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetController = TextEditingController(text: '1');
  HabitType _type = HabitType.positive;
  HabitFrequency _frequency = HabitFrequency.daily;
  bool _hasTodoList = false;
  int _completionThreshold = 70;
  Habit? _editingHabit;
  List<TodoItemModel> _todoItems = [];

  bool get _isEditing => widget.habitId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      context.read<HabitsCubit>().loadHabit(widget.habitId!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(_isEditing ? 'Edit Habit' : 'Add Habit'),
      ),
      body: BlocConsumer<HabitsCubit, HabitsState>(
        listener: (context, state) {
          if (state is HabitsLoaded) {
            if (_isEditing && state.selectedHabit != null) {
              _applyHabit(state.selectedHabit!);
            }
          }
          if (state is HabitsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is HabitsLoading;
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TabChip(
                        label: 'Positive',
                        selected: _type == HabitType.positive,
                        onTap: () => setState(() => _type = HabitType.positive),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _TabChip(
                        label: 'Shadow',
                        selected: _type == HabitType.shadow,
                        onTap: () => setState(() => _type = HabitType.shadow),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Habit name',
                    hintText: _type == HabitType.positive
                        ? 'Read 10 pages'
                        : 'Doom scrolling',
                    prefixIcon: Icon(
                      _type == HabitType.positive
                          ? PhosphorIconsBold.checkCircle
                          : PhosphorIconsBold.skull,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a habit name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Target count',
                    hintText: '1',
                  ),
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed < 1) {
                      return 'Enter a target of 1 or more';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Frequency',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ...HabitFrequency.values.map(
                  (frequency) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GlassCard(
                      onTap: () => setState(() => _frequency = frequency),
                      borderColor: _frequency == frequency
                          ? AppColors.accent
                          : null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _frequency == frequency
                                ? PhosphorIconsFill.checkCircle
                                : PhosphorIconsBold.circle,
                            color: _frequency == frequency
                                ? AppColors.accent
                                : AppColors.textMuted,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              frequency.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Enable Checklist'),
                  subtitle: const Text('Add multiple items to complete this habit'),
                  value: _hasTodoList,
                  onChanged: (value) {
                    setState(() => _hasTodoList = value);
                  },
                ),
                if (_hasTodoList) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Completion Threshold: $_completionThreshold%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Slider(
                    value: _completionThreshold.toDouble(),
                    min: 50,
                    max: 100,
                    divisions: 50,
                    label: '$_completionThreshold%',
                    onChanged: (v) {
                      setState(() => _completionThreshold = v.toInt());
                    },
                  ),
                  const SizedBox(height: 8),
                  if (_isEditing)
                    TodoChecklistWidget(
                      parentId: widget.habitId!,
                      parentType: 'habit',
                      readOnly: true,
                    )
                  else
                    _TodoPreviewWidget(
                      initialItems: _todoItems,
                      onChanged: (items) {
                        setState(() => _todoItems = items);
                      },
                    ),
                ],
                const SizedBox(height: 24),
                RizenButton(
                  label: _isEditing ? 'Save Habit' : 'Create Habit',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _applyHabit(Habit habit) {
    if (_editingHabit?.id == habit.id) return;
    _editingHabit = habit;
    _nameController.text = habit.name;
    _targetController.text = habit.targetCount.toString();
    setState(() {
      _type = habit.type;
      _frequency = habit.frequency;
      _hasTodoList = habit.hasTodoList;
      _completionThreshold = habit.completionThreshold;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<HabitsCubit>();
    final saveTodoList = context.read<SaveTodoListUseCase>();
    final targetCount = int.parse(_targetController.text);
    if (_isEditing && _editingHabit != null) {
      await cubit.updateHabit(
        _editingHabit!.copyWith(
          name: _nameController.text.trim(),
          type: _type,
          frequency: _frequency,
          targetCount: targetCount,
          hasTodoList: _hasTodoList,
          completionThreshold: _completionThreshold,
        ),
      );
      if (_hasTodoList && _todoItems.isNotEmpty) {
        try {
          final todoList = TodoListModel(
            id: widget.habitId!,
            parentId: widget.habitId!,
            parentType: 'habit',
            items: _todoItems
                .map((item) => item.copyWith(
                      parentId: widget.habitId!,
                      parentType: 'habit',
                    ))
                .toList(),
            completionThreshold: _completionThreshold,
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
      if (mounted) context.pop();
      return;
    }

    final habit = await cubit.createHabit(
      name: _nameController.text.trim(),
      type: _type,
      frequency: _frequency,
      targetCount: targetCount,
      hasTodoList: _hasTodoList,
      completionThreshold: _completionThreshold,
    );
    if (habit == null) return;

    if (_hasTodoList && _todoItems.isNotEmpty) {
      try {
        final todoList = TodoListModel(
          id: habit.id,
          parentId: habit.id,
          parentType: 'habit',
          items: _todoItems
              .map((item) => item.copyWith(
                    parentId: habit.id,
                    parentType: 'habit',
                  ))
              .toList(),
          completionThreshold: _completionThreshold,
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

    if (mounted) context.pop();
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.accent.withValues(alpha: 0.2)
              : AppColors.glassFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.glassBorder,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
