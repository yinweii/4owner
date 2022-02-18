import 'package:flutter/material.dart';
import 'package:owner_app/constants/app_text.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/utils/utils.dart';

import '../customer_detail.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {Key? key,
      this.id,
      this.name,
      this.phoneNumber,
      this.floorName,
      this.roomNumber})
      : super(key: key);
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? floorName;
  final String? roomNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: GestureDetector(
        onTap: () => Utils.navigatePage(context, CustomerDetail(id: id)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              child: Icon(Icons.account_circle_outlined),
            ),
            title: Text(
              '$name',
              style: AppTextStyles.defaulLato.copyWith(
                fontSize: AppTextStyles.fontSize_18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  floorName ?? '',
                  style: AppTextStyles.defaulLato.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: AppTextStyles.fontSize_14,
                  ),
                ),
                SizedBox(width: 3),
                Text(
                   roomNumber ?? '',
                  style: AppTextStyles.defaulLato.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: AppTextStyles.fontSize_14,
                  ),
                ),
              ],
            ),
            trailing: Text(
              phoneNumber ?? '',
              style: AppTextStyles.defaulLato.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppTextStyles.fontSize_14,
                color: AppColors.greenFF79AF91,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
