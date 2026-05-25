import '../repositories/auth_repository.dart';

class UploadMediaUseCase {
  const UploadMediaUseCase(this._repository);

  final AuthRepository _repository;

  Future<String?> call(String filePath) {
    return _repository.uploadMedia(filePath);
  }
}
