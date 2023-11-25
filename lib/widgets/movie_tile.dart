import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  MovieTile({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        movie.imageUrl,
        width: 50,
        height: 50,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.summary),
      onTap: onTap,
    );
  }
}
