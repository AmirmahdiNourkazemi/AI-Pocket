

import 'package:appro_chat/core/resources/data_state.dart';
import 'package:appro_chat/core/usecase/use_case.dart';
import 'package:appro_chat/feature/auth/domain/repository/auth_repository.dart';

class GoogleUseCase implements UseCase<DataState<String>, NoParams> {
  final AuthRepository authRepository;
  GoogleUseCase(this.authRepository);
  @override
  Future<DataState<String>> call(NoParams params) async{
    return await authRepository.signInWithGoogle() as DataState<String>;
  }
}