import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final GlobalKey<ShoppingCartIconState> shoppingCart =
    GlobalKey<ShoppingCartIconState>();
final GlobalKey<ProductListWidgetState> productList =
    GlobalKey<ProductListWidgetState>();

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store Glu',
      home: MyStorePage(),
    )
  );
}

class MyStorePage extends StatefulWidget {
  MyStorePage({Key? key}) : super(key: key);

  @override
  MyStorePageState createState() => MyStorePageState();
}

class MyStorePageState extends State<MyStorePage> {

  bool _inSearch = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  void _toggleSearch() {
    setState(() {
      _inSearch = !_inSearch;
    });

    _controller.clear();
    productList.currentState!.productList = Server.getProductList();
  }

  void _handleSearch() {
    _focusNode.unfocus();
    final String filter = _controller.text;
    productList.currentState!.productList = Server.getProductList(filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset('$images/anh-troll-4.jpg')
            ),
            title: _inSearch
                ? TextField(
                autofocus: true,
                focusNode: _focusNode,
                controller: _controller,
                onSubmitted: (_) => _handleSearch(),
                decoration: InputDecoration(
                  hintText: 'Search Google Store',
                  prefixIcon: IconButton(icon: Icon(Icons.search), onPressed: _handleSearch),
                  suffixIcon: IconButton(icon: Icon(Icons.close), onPressed: _toggleSearch),
                )
            )
                : null,
            actions: [
              if (!_inSearch) IconButton(onPressed: _toggleSearch, icon: Icon(Icons.search, color: Colors.black)),
              ShoppingCartIcon(key: shoppingCart),
            ],
            backgroundColor: Colors.pinkAccent,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ProductListWidget(key: productList),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartIcon extends StatefulWidget {
  ShoppingCartIcon({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShoppingCartIconState();
}

class ShoppingCartIconState extends State<ShoppingCartIcon> {
  Set<String> get itemsInCart => _itemsInCart;
  Set<String> _itemsInCart = <String>{};
  set itemsInCart(Set<String> value) {
    setState(() {
      _itemsInCart = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPurchase = itemsInCart.length > 0;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: hasPurchase ? 17.0 : 10.0),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.deepPurple,
          ),
        ),
        if (hasPurchase)
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: CircleAvatar(
              radius: 8.0,
              backgroundColor: Colors.green,
              foregroundColor: Colors.pink,
              child: Text(
                itemsInCart.length.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProductListWidget extends StatefulWidget {
  ProductListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductListWidgetState();
}

class ProductListWidgetState extends State<ProductListWidget> {
  List<String> get productList => _productList;
  List<String> _productList = Server.getProductList();
  set productList(List<String> value) {
    setState(() {
      _productList = value;
    });
  }

  Set<String> get itemsInCart => _itemsInCart;
  Set<String> _itemsInCart = <String>{};
  set itemsInCart(Set<String> value) {
    setState(() {
      _itemsInCart = value;
    });
  }

  void _handleAddToCart(String id) {
    itemsInCart = _itemsInCart..add(id);
    shoppingCart.currentState!.itemsInCart = itemsInCart;
  }

  void _handleRemoveFromCart(String id) {
    itemsInCart = _itemsInCart..remove(id);
    shoppingCart.currentState!.itemsInCart = itemsInCart;
  }

  Widget _buildProductTile(String id) {
    return ProductTile(
      product: Server.getProductById(id),
      purchased: itemsInCart.contains(id),
      onAddToCart: () => _handleAddToCart(id),
      onRemoveFromCart: () => _handleRemoveFromCart(id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: productList.map(_buildProductTile).toList(),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile(
      {Key? key,
      required this.product,
      required this.purchased,
      required this.onAddToCart,
      required this.onRemoveFromCart})
      : super(key: key);

  final Product product;
  final bool purchased;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;

  @override
  Widget build(BuildContext context) {
    Color getButtonColor(Set<MaterialState> states) {
      return purchased ? Colors.green : Colors.black;
    }

    BorderSide getButtonSide(Set<MaterialState> states) {
      return BorderSide(
        color: purchased ? Colors.green : Colors.black,
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 40,
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(product.title),
          ),
          Text.rich(
            product.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: OutlinedButton(
              child: purchased
                  ? const Text('Remove from cart')
                  : const Text("Add to cart"),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith(getButtonColor),
                side: MaterialStateProperty.resolveWith(getButtonSide),
              ),
              onPressed: purchased ? onRemoveFromCart : onAddToCart,
            ),
          ),
          Image.asset(product.pictureUrl),
        ],
      ),
    );
  }
}

// The code below is for the dummy server, and you should not need to modify it
// in this workshop.

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/inherited_widget/assets';
const String images = 'assets/images';

const Map<String, Product> kDummyData = {
  '0': Product(
    id: '0',
    title: 'Vegetable Pizza',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Oishi.\n', style: TextStyle(color: Colors.red)),
      TextSpan(text: 'Hấp Dẫn.', style: TextStyle(color: Colors.yellow)),
    ]),
    pictureUrl: '$images/vegetable-pizza.jpg',
  ),
  '1': Product(
    id: '1',
    title: 'Cheese Pizza',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
          text: 'Phô Mai 2 lớp.\n',
          style: TextStyle(color: Colors.greenAccent)),
      TextSpan(text: 'Ngon Lắm.', style: TextStyle(color: Colors.black)),
    ]),
    pictureUrl: '$images/h2.jpg',
  ),
  '2': Product(
    id: '2',
    title: 'Italian Pizza',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Cũng Được .\n', style: TextStyle(color: Colors.orange)),
      TextSpan(text: 'Đặc sắc.', style: TextStyle(color: Colors.pinkAccent)),
    ]),
    pictureUrl: '$images/italian-pizza.jpg',
  ),
  '3': Product(
    id: '3',
    title: 'Vegetable Pizza',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Healthy .\n', style: TextStyle(color: Colors.red)),
      TextSpan(text: 'Healthy.\n', style: TextStyle(color: Colors.yellow)),
    ]),
    pictureUrl: '$images/veg.jpg',
  ),
};

class Server {
  static Product getProductById(String id) {
    return kDummyData[id]!;
  }

  static List<String> getProductList({String? filter}) {
    if (filter == null) return kDummyData.keys.toList();
    final List<String> ids = <String>[];
    for (final Product product in kDummyData.values) {
      if (product.title.toLowerCase().contains(filter.toLowerCase())) {
        ids.add(product.id);
      }
    }
    return ids;
  }
}

class Product {
  const Product(
      {required this.id,
      required this.pictureUrl,
      required this.title,
      required this.description});

  final String id;
  final String pictureUrl;
  final String title;
  final TextSpan description;
}
