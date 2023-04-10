import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/cubit/promotion_cubit.dart';
import '../business_logic/cubit/voucher_cubit.dart';
import '../../presentation/pages/promotion_page.dart';
import '../../presentation/pages/voucher_page.dart';

import '../res/dimen/dimens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget _page;
  final Widget _voucherPage = const VoucherPage();
  final Widget _promotionPage = const PromotionPage();
  int selected = 0;

  @override
  void initState() {
    _page = _voucherPage;
    context.read<VoucherCubit>().fetchData();
    context.read<PromotionCubit>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BLoC Architecture',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spaceSM,
        ),
        child: _page,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (value) {
            setState(() {
              selected = value;
              if (value == 0) {
                _page = _voucherPage;
              } else {
                _page = _promotionPage;
              }
            });
          },
          currentIndex: selected,
          unselectedItemColor: Colors.black87,
          selectedItemColor: Colors.orange,
          items: const [
            BottomNavigationBarItem(
              label: 'Voucher',
              icon: Icon(Icons.confirmation_num_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Promotion',
              icon: Icon(Icons.account_balance_wallet_outlined),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.ac_unit_outlined),
      ),
    );
  }
}
