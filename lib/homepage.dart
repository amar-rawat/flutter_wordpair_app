import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _randomWordPairs = <WordPair>[];

  final _savedWordPairs = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Word Pairs',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _pushSaved();
            },
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, item) {
            if (item.isOdd) return const Divider();
            final index = item ~/ 2;
            if (index >= _randomWordPairs.length) {
              _randomWordPairs.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_randomWordPairs[index]);
          }),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
      trailing: Icon(
        alreadySaved ? Icons.favorite_outlined : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final Iterable<ListTile> tiles = _savedWordPairs.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: const TextStyle(fontSize: 18.0),
                ),
              );
            },
          );
          final divided =
              ListTile.divideTiles(context: context, tiles: tiles).toList();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favourites'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
