import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import '../utils/network_manager.dart';
import '../widgets/item_widget.dart';

class TodoDonePage extends StatefulWidget {
  const TodoDonePage({super.key});

  @override
  State<TodoDonePage> createState() => _TodoDonePageState();
}

class _TodoDonePageState extends State<TodoDonePage> {
  bool isLoading = false;
  List<TodoItem> todos = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    NetworkManager().getTodosIsDone(true).then((value) {
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
        title: const Text('Daftar Todo Selesai'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Todo yang telah diselesaikan'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ItemWidget(
                    item: todos[index],
                    handleRefresh: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
