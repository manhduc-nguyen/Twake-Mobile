import 'package:get/get.dart';
import 'package:twake/blocs/channels_cubit/member_management_cubit/member_management_cubit.dart';
import 'package:twake/blocs/workspaces_cubit/workspaces_cubit.dart';

class MemberManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MemberManagementCubit(workspacesCubit: Get.find<WorkspacesCubit>()));
  }
}
