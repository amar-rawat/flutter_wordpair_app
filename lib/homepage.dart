import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final wordPairs = <WordPair>[];

  final savedWords = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Pairs'),
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, item) {
            if (item.isOdd) return const Divider();
            final index = item ~/ 2;
            if (index >= wordPairs.length) {
              wordPairs.addAll(generateWordPairs().take(10));
            }
            return _buildRow(wordPairs[index]);
          }),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = savedWords.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
      trailing: Icon(
        alreadySaved ? Icons.favorite_outlined : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            savedWords.remove(pair);
          } else {
            savedWords.add(pair);
          }
        });
      },
    );
  }
}
