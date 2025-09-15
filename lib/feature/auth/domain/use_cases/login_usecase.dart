import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/auth_repository.dart';

class LoginUsecase implements UseCase<DataState<String>, String>{
  final AuthRepository authRepository;

  LoginUsecase( this.authRepository);
  @override
  Future<DataState<String>> call(String params) {
    return authRepository.loginGoogleApprroo(params);
  }
  
}