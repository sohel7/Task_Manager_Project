import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SamaryCard extends StatelessWidget {
  const SamaryCard({
    super.key,
    required this.count,
    required this.title
  });
  final String count, title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
        child: Column(
          children: [
            Text(count,style: Theme.of(context).textTheme.titleLarge,),
            Text(title),
          ],
        ),
      ),
    );
  }
}
