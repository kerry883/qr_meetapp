import 'package:get_it/get_it.dart';
import 'package:qr_meetapp/data/repositories/appointment_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  if (!getIt.isRegistered<AppointmentRepository>()) {
    getIt.registerLazySingleton<AppointmentRepository>(() => AppointmentRepository());
  }
}
