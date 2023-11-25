import 'package:flutter/material.dart';
import 'package:quadb/services/api_services.dart';
import '../widgets/movie_tile.dart';
import '../models/movie.dart';
import 'details_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Movies'),
      ),
      body: FutureBuilder(
        future: apiService.fetchMovies('all'), // Corrected method name
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Movie> movies = (snapshot.data as List<Movie>?) ?? [];
            return ListView.builder(
              itemCount: 10000, // A large number to simulate infinite scrolling
              itemBuilder: (context, index) {
                final movieIndex = index % movies.length;
                return MovieTile(
                  movie: movies[movieIndex],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          movie: movies[movieIndex],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.lightBlue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          }
        },
      ),
    );
  }
}
