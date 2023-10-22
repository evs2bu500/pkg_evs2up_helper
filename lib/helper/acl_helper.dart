import 'package:evs2up_helper/evs2up_helper.dart';

String getAclTargetStr(AclTarget target) {
  return target.name.replaceAll('_p_', '.');
}
