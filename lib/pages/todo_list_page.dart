import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import '../utils/network_manager.dart';
import '../widgets/item_widget.dart';
import 'form_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = false;
  List<TodoItem> todos = [];
  int totalDone = 0;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    setState(() {
      isLoading = true;
    });

    NetworkManager().getTodosIsDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
    });

    NetworkManager().getTodosIsDone(false).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Todo List',
                  style: textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sudah diselesaikan $totalDone',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: todos.isEmpty
                        ? const Center(
                            child: Text('Tidak ada data'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemWidget(item: todos[index]);
                            },
                            itemCount: todos.length,
                          ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
