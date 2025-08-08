import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> recentSearches = [
    "Tollan Worlds",
    "Stargate Combat",
    "Apex Legends",
    "Galactic Fleet",
    "Space Strategy",
  ];

  String _searchQuery = '';
  bool _isTyping = false;

  void _onTextChanged(String value) {
    setState(() {
      _searchQuery = value;
      _isTyping = true;
    });
  }

  void _onSearchSubmitted(String value) {
    setState(() {
      _searchQuery = value.trim();
      _isTyping = false;
    });
    // Optionally store to recentSearches here
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _searchQuery = '';
      _isTyping = false;
    });
  }

  List<String> _getFilteredResults() {
    return recentSearches
        .where(
            (item) => item.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _getFilteredResults();

    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B111D),
                        border: Border.all(
                            color: const Color(0xFFFDEB56), width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Image.asset(
                              'assets/icons/Search.png', // Replace with your actual image path
                              width: 24, // Adjust size as needed
                              height: 24,
                              color:
                                  Colors.yellow, // Optional: apply a color tint
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: AppTextStyles.small(color: Colors.white),
                              onChanged: _onTextChanged,
                              onSubmitted: _onSearchSubmitted,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle:
                                    AppTextStyles.small(color: Colors.white54),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CircleAvatar(
                              radius: 8, // Adjust for small size
                              backgroundColor:
                                  Color(0xFF3E3540), // or any color you want
                              child: IconButton(
                                padding:
                                    EdgeInsets.zero, // remove default padding
                                iconSize: 12, // make icon smaller
                                icon: const Icon(Icons.close,
                                    color: Color(0xFF9F9AA0)),
                                onPressed: _clearSearch,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _searchQuery.isEmpty
                      ? 'Recent Searches'
                      : _isTyping
                          ? 'What we found'
                          : 'Results',
                  style: AppTextStyles.small(
                    size: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _searchQuery.isEmpty
                      ? recentSearches.length
                      : results.length,
                  itemBuilder: (context, index) {
                    final item = _searchQuery.isEmpty
                        ? recentSearches[index]
                        : results[index];

                    // Show simple history icon for recent searches
                    if (_searchQuery.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.history,
                                color: Colors.grey[400], size: 20),
                            const SizedBox(width: 12),
                            Text(
                              item,
                              style: AppTextStyles.small(
                                  color: Colors.grey, size: 15),
                            ),
                          ],
                        ),
                      );
                    }

                    // Show styled search result when typing
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C131F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(
                                0xFF281F2A), // Change to Colors.grey.shade700 for subtler look
                            width: 1,
                          ),
                        ),
                        padding:
                            const EdgeInsets.all(4), // padding inside the tile
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/bg/tile_bg.png',
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    item,
                                    style: AppTextStyles.small(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.article_outlined,
                                          size: 16, color: Colors.white54),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Tutorial',
                                        style: AppTextStyles.small(
                                            color: Colors.white54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> searchResults = [
  {
    "title": "Apex Legend",
    "subtitle": "Tutorial",
    "image": "assets/apex_cover.jpg",
    "icon": Icons.school,
  },
  {
    "title": "Apex Legend",
    "subtitle": "Articles",
    "image": "assets/apex_cover.jpg",
    "icon": Icons.article_outlined,
  },
];
