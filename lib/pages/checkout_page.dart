import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/models/myorder.dart';
import 'package:restaurant/models/product.dart';
import 'package:restaurant/pages/profile_page.dart';
import 'package:restaurant/services/firebase_service.dart';
import 'home_page.dart';

class PriceItem {
  PriceItem(
      {required this.name,
      required this.quantity,
      required this.totalPriceCents});

  final String name;
  final int quantity;
  final int totalPriceCents;
  String get price => (totalPriceCents.toDouble()).toStringAsFixed(2);

  @override
  String toString() {
    return 'PriceItem [ name: $name, quantity: $quantity, totalPriceCents: $totalPriceCents ]';
  }
}

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPage();
}

class _CheckOutPage extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    const double _spacing = 30.0;
    const double _padding = 18.0;
    const double _dividerThickness = 1.2;
    const double _collapsedAppBarHeight = 100;
    User? user = FirebaseAuth.instance.currentUser;
    final List<PriceItem> priceItems = [];
    for (var item in HomePage.selecteditems) {
      priceItems.add(fromProducts(item));
    }

    int _priceCents = 0;
    for (var item in priceItems) {
      _priceCents += item.totalPriceCents;
    }
    final List<PriceItem> _priceItems = priceItems;
    _priceItems.add(
        PriceItem(name: 'Total', quantity: 1, totalPriceCents: _priceCents));

    final String _priceString = (_priceCents.toDouble()).toStringAsFixed(2);

    final double _expHeight = (_priceItems.length * 50) + 165;

    final double _initHeight = _expHeight - (_collapsedAppBarHeight + 30.0);

    // ignore: no_leading_underscores_for_local_identifiers
    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: _initHeight);

    final GlobalKey<_StatefullWrapperState> textKey =
        GlobalKey<_StatefullWrapperState>();

    const Widget textWhileClosed = Text(
      'View Details',
      style: TextStyle(fontSize: 12.0),
    );
    const Widget textWhileOpen = Text(
      'Hide Details',
      style: TextStyle(fontSize: 12.0),
    );

    bool _isOpen = false;

    // add the listener to the scroll controller mentioned above
    _scrollController.addListener(() {
      final bool result = (_scrollController.offset <= (2 * _initHeight / 3));
      if (result != _isOpen) {
        _isOpen = result;
        if (_isOpen) {
          textKey.currentState?.setchild(textWhileOpen);
        } else {
          textKey.currentState?.setchild(textWhileClosed);
        }
      }
    });
    String payToName = 'Nhom18';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Out"),
        backgroundColor: Colors.yellow.shade900,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            backgroundColor: Colors.grey.shade50,
            collapsedHeight: _collapsedAppBarHeight,
            // set to false to prevent undesired back arrow
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const SizedBox(
                  width: 40,
                  child: Text(''),
                ),
                Expanded(
                    child: Text(
                  payToName.length < 16 ? '$payToName Checkout' : payToName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 26, color: Colors.black),
                )),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size(120.0, 32.0),
              child: GestureDetector(
                onTap: () {
                  if (_isOpen) {
                    _scrollController.jumpTo(_initHeight);
                  } else {
                    _scrollController.jumpTo(0);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Charge Amount '),
                    Text(
                      '\$$_priceString',
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    _StatefullWrapper(
                      key: textKey,
                      initChild: textWhileClosed,
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: _expHeight,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 80, 16.0, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: _priceItems
                          .map((priceItem) =>
                              _PriceListItem(priceItem: priceItem))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if (true) const SizedBox(height: _spacing * 2),
                      if (true)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_cart_checkout),
                          label: const Text("Order"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow.shade900,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            MyOrder myOrder = MyOrder(
                                username: user?.email,
                                products: HomePage.selecteditems,
                                total: _priceCents);
                            FirebaseService firebaseService = FirebaseService();
                            firebaseService.createOrder(myOrder);
                          },
                        ),
                      const SizedBox(
                        height: _spacing,
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> toPriceItemJson(Product a) {
    return {
      'name': a.title,
      'quantity': 1,
      'totalPriceCents': a.price,
    };
  }

  static PriceItem fromProducts(Product a) {
    return PriceItem(
      name: a.title,
      quantity: 1,
      totalPriceCents: a.price.toInt(),
    );
  }
}

class _PriceListItem extends StatelessWidget {
  const _PriceListItem({Key? key, required this.priceItem}) : super(key: key);

  final PriceItem priceItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    priceItem.name,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: (priceItem.quantity == 1)
                      ? Container()
                      : Text(
                          'x${priceItem.quantity}',
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '\$${priceItem.price}',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatefullWrapper extends StatefulWidget {
  const _StatefullWrapper({Key? key, required this.initChild})
      : super(key: key);
  final Widget initChild;

  @override
  _StatefullWrapperState createState() => _StatefullWrapperState();
}

class _StatefullWrapperState extends State<_StatefullWrapper> {
  late Widget child;

  setchild(Widget newChild) {
    setState(() {
      child = newChild;
    });
  }

  @override
  void initState() {
    super.initState();
    child = widget.initChild;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
