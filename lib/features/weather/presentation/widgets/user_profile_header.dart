import 'package:cached_network_image/cached_network_image.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:cellula_task/features/user/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileHeader extends StatelessWidget {
  final UserEntity userEntity;
  final VoidCallback onLogout;

  const UserProfileHeader({
    super.key,
    required this.userEntity,
    required this.onLogout,
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
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: onLogout,
          ),
        ],
      ),
    );
  }
}
