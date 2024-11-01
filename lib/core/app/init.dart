import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../util/constants.dart';

initApp() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: Constants.supabaseUrl, anonKey: Constants.supabaseAnon);
}
