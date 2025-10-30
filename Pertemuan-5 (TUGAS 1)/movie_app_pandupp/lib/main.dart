import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MovieHomePage(),
    );
  }
}

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Now Playing Section with Card Swiper
              _buildNowPlayingSection(),

              const SizedBox(height: 20),

              // Trending Section
              _buildMovieSection(
                title: 'Trending',
                movies: _getTrendingMovies(),
              ),

              const SizedBox(height: 20),

              // Popular Section
              _buildMovieSection(title: 'Popular', movies: _getPopularMovies()),

              const SizedBox(height: 20),

              // Top Rated Section
              _buildMovieSection(
                title: 'Top Rated',
                movies: _getTopRatedMovies(),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildNowPlayingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'PanduPP',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 450,
          child: Swiper(
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildNowPlayingCard(index);
            },
            viewportFraction: 0.85,
            scale: 0.9,
            loop: true,
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Colors.white,
                size: 8,
                activeSize: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNowPlayingCard(int index) {
    final movies = [
      {
        'title': 'Deadpool & Wolverine',
        'genre': 'Action',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
        'color': Colors.red,
      },
      {
        'title': 'Inception',
        'genre': 'Sci-Fi',
        'description':
            'A thief who steals corporate secrets through dream-sharing technology...',
        'color': Colors.blue,
      },
      {
        'title': 'The Dark Knight',
        'genre': 'Action',
        'description':
            'When the menace known as the Joker wreaks havoc and chaos...',
        'color': Colors.purple,
      },
    ];

    final movie = movies[index];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [(movie['color'] as Color).withOpacity(0.3), Colors.black],
        ),
      ),
      child: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/400/600?random=$index',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                  Colors.black,
                ],
              ),
            ),
          ),

          // Content
          Positioned(
            bottom: 20,
            left: 20,
            right: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'] as String,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['genre'] as String,
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['description'] as String,
                  style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Arrow Button
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieSection({
    required String title,
    required List<Map<String, String>> movies,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'More',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _buildMovieCard(movies[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCard(Map<String, String> movie) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(movie['image']!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.grey[800]!, width: 0.5)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Genre'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getTrendingMovies() {
    return [
      {'title': 'Bad Boys', 'image': 'https://picsum.photos/130/200?random=10'},
      {
        'title': 'Inside Out 2',
        'image': 'https://picsum.photos/130/200?random=11',
      },
      {
        'title': 'A Quiet Place',
        'image': 'https://picsum.photos/130/200?random=12',
      },
      {'title': 'Movie 4', 'image': 'https://picsum.photos/130/200?random=13'},
    ];
  }

  List<Map<String, String>> _getPopularMovies() {
    return [
      {'title': 'Movie 1', 'image': 'https://picsum.photos/130/200?random=20'},
      {'title': 'Fallout', 'image': 'https://picsum.photos/130/200?random=21'},
      {'title': 'Movie 3', 'image': 'https://picsum.photos/130/200?random=22'},
      {'title': 'Movie 4', 'image': 'https://picsum.photos/130/200?random=23'},
    ];
  }

  List<Map<String, String>> _getTopRatedMovies() {
    return [
      {'title': 'Movie 1', 'image': 'https://picsum.photos/130/200?random=30'},
      {
        'title': 'The Last of Us',
        'image': 'https://picsum.photos/130/200?random=31',
      },
      {
        'title': 'Perfect Days',
        'image': 'https://picsum.photos/130/200?random=32',
      },
      {'title': 'Movie 4', 'image': 'https://picsum.photos/130/200?random=33'},
    ];
  }
}
