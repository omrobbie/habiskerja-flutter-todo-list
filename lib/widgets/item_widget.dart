import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import '../utils/network_manager.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.item,
    required this.handleRefresh,
  }) : super(key: key);

  final Function() handleRefresh;
  final TodoItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.isDone ? Colors.grey : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(item.description),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if (!item.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  await NetworkManager().updateData(
                    item.copyWith(isDone: true),
                  );
                  handleRefresh();
                },
                child: const Icon(Icons.check),
              ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {},
              child: const Icon(Icons.delete_forever),
            )
          ],
        ),
      ),
    );
  }
}
