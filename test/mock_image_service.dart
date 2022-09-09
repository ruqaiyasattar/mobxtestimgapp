import 'package:mobxtestingdemo/services/image_upload_service.dart';

class MockImageService implements ImageUploadService {
  @override
  Future<ImageID?> uploadImage({
    required String filePath,
    required String userId,
    required String imageId,
  }) async => 'mock_image_id';
}