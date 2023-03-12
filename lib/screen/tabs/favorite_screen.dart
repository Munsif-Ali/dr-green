import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<String> _favoritesBlogs = [];
  final List<String> _favoritesProducts = [];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: ('Blogs'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: ('Products'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        children: <Widget>[
          _buildBlogView(),
          _buildProductView(),
        ],
        controller: PageController(initialPage: _selectedIndex),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (_selectedIndex == 0) {
      //       _showAddBlogDialog();
      //     } else {
      //       _showAddProductDialog();
      //     }
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget _buildBlogView() {
    return ListView.builder(
      itemCount: _favoritesBlogs.length,
      itemBuilder: (context, index) {
        // return Column(
        //   children: [
        //     DropdownButton<int>(
        //       items: [
        //         DropdownMenuItem(
        //           child: Text("${roleModel.role}"),
        //           value: roleModel.id,
        //         ),
        //       ],
        //       onChanged: (value) {},
        //     ),
        //   ],
        // );
        return ListTile(
          title: Text(_favoritesBlogs[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _favoritesBlogs.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildProductView() {
    return ListView.builder(
      itemCount: _favoritesProducts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_favoritesProducts[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _favoritesProducts.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  void _showAddBlogDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add to Favorites'),
          content: TextField(
            onSubmitted: (value) {
              setState(() {
                _favoritesBlogs.add(value);
              });
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add to Favorites'),
          content: TextField(
            onSubmitted: (value) {
              setState(() {
                _favoritesProducts.add(value);
              });
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
