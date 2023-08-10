import 'package:flutter/material.dart';

import '../../repository/customer_details_repo/customer_profile_repo.dart';


class CustomerProfileService extends ChangeNotifier {
  final CustomerProfileRepo customerProfileRepo;

  CustomerProfileService({required this.customerProfileRepo});

  Future getCustomerProfileService(String userId) async {
    return await customerProfileRepo.getCustomerProfileRepo(userId);
  }

}
