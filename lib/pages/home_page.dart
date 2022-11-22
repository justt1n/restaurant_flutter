import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant/models/product.dart';
import 'package:restaurant/pages/checkout_page.dart';
import 'package:restaurant/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({required this.user});

  static List<Product> selecteditems = [];
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Badge(
                  animationDuration: const Duration(milliseconds: 1500),
                  badgeContent: Text(
                    HomePage.selecteditems.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.all(6),
                  badgeColor: Colors.yellow.shade900,
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Food Delivery',
                style: style.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              TabBar(
                  automaticIndicatorColorAdjustment: true,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow.shade900),
                  labelColor: Colors.white,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  unselectedLabelColor: Colors.grey.shade700,
                  controller: _controller,
                  labelStyle:
                      style.copyWith(fontSize: 13, fontWeight: FontWeight.w900),
                  tabs: const [
                    Tab(
                      text: 'Burgers',
                    ),
                    Tab(
                      text: 'Pizzas',
                    ),
                    Tab(
                      text: 'Drinks',
                    ),
                    Tab(
                      text: 'Meals',
                    ),
                  ]),
              const SizedBox(
                height: 28,
              ),
              Text(
                'Free Delivery',
                style: style.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: [
                      _buildlistitem(
                          itemlist: burgeritems, length: burgeritems.length),
                      _buildlistitem(
                          itemlist: pizzaitems, length: pizzaitems.length),
                      _buildlistitem(
                          itemlist: drinksitems, length: drinksitems.length),
                      _buildlistitem(
                          itemlist: mealsitems, length: mealsitems.length),
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(20)),
                  //padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const CheckOutPage(),
                              duration: const Duration(seconds: 1),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Text(
                      'Order',
                      style: style.copyWith(fontSize: 22),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(20)),
                  //padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        HomePage.selecteditems = [];
                        _isSigningOut = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign out',
                      style: style.copyWith(fontSize: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildlistitem({required int length, required List itemlist}) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: length,
        itemBuilder: (_, index) {
          return _buildcard(index: index, myitemlist: itemlist);
        });
  }

  Widget _buildcard({required int index, required List myitemlist}) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(
                myitemlist[index].image,
              ),
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ],
                begin: Alignment.bottomCenter,
                stops: const [.2, .6]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        myitemlist[index].isSelected =
                            !myitemlist[index].isSelected;
                        if (myitemlist[index].isSelected) {
                          HomePage.selecteditems.add(myitemlist[index]);
                        } else {
                          HomePage.selecteditems.removeAt(index);
                        }
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: myitemlist[index].isSelected
                          ? Colors.red
                          : Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '\$ ${myitemlist[index].price}',
                  style: style.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  myitemlist[index].title,
                  style: style.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
