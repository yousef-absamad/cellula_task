import 'package:cached_network_image/cached_network_image.dart';
import 'package:cellula_task/core/routing/app_routes.dart';
import 'package:cellula_task/core/services/services_locator.dart';
import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_cubit.dart';
import 'package:cellula_task/features/auth/presentation/controller/auth_state.dart';
import 'package:cellula_task/features/user/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserProfileHeader extends StatelessWidget {
  final UserEntity userEntity;
  const UserProfileHeader({
    super.key,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            backgroundImage: userEntity.profileImage.isNotEmpty
                ? CachedNetworkImageProvider(userEntity.profileImage)
                : null,
            child: userEntity.profileImage.isEmpty
                ? Text(
                    userEntity.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const WidthSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(6),
                Text(
                  userEntity.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userEntity.email,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) =>
                  current is LogoutLoading || current is LogoutSuccess,
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.black),
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                    GoRouter.of(context).goNamed(AppRoutes.loginScreen);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
