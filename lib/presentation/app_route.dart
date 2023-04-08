import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/home_cubit.dart';
import '../../presentation/screens/home_screen.dart';

import '../business_logic/cubit/promotion_cubit.dart';
import '../business_logic/cubit/voucher_cubit.dart';

class AppRoute {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<VoucherCubit>(
                create: (context) => VoucherCubit(),
              ),
              BlocProvider<PromotionCubit>(
                create: (context) => PromotionCubit(),
              ),
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
    }
    return null;
  }
}
