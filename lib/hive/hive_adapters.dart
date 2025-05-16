import 'package:hive_ce/hive.dart';
import 'package:rewo_supplier/models/create_registration_model.dart';
import 'package:rewo_supplier/models/user_model.dart';

@GenerateAdapters([
  AdapterSpec<UserModel>(),
  AdapterSpec<RegistrationStatus>(),
  AdapterSpec<Location>(),
  AdapterSpec<MaterialTypesModel>(),
  AdapterSpec<BankDetails>(),
  AdapterSpec<SupllierMedia>(),
])
part 'hive_adapters.g.dart';
