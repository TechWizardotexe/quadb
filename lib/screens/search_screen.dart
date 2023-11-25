import 'package:flutter/material.dart';
import 'package:quadb/screens/details_screen.dart';
import 'package:quadb/services/api_services.dart';
import '../models/movie.dart';
import '../widgets/movie_tile.dart';
import 'home_screen.dart'; // Import the HomeScreen

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Movie> _searchResults = [];

  _onSearchSubmitted(String query) async {
    if (query.isNotEmpty) {
      List<Movie> results = await _apiService.fetchMovies(query);
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              hintText: 'Search Movies',
              hintStyle: TextStyle(color: Colors.white)),
          onSubmitted: _onSearchSubmitted,
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Text('No results found',
                  style: TextStyle(color: Colors.white)),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return MovieTile(
                  movie: _searchResults[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          movie: _searchResults[index],
                        ),
                      ),
                    );
                  },
                );
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
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
      ),
      backgroundColor: Colors.black, // Set the background color of the Scaffold
    );
  }
}
