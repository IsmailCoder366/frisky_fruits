import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // Add this

class ProfileRepository {
  final String _cloudName = "dezkkfpex";
  final String _uploadPreset = "profile_image";

  // Modify to accept XFile instead of String path
  Future<String> uploadToCloudinary(XFile pickedFile) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$_cloudName/image/upload");

    var request = http.MultipartRequest("POST", url);
    request.fields['upload_preset'] = _uploadPreset;

    // WEB FIX: Read bytes instead of using file path
    final bytes = await pickedFile.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: pickedFile.name,
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['secure_url'];
    } else {
      throw Exception("Cloudinary Error: ${response.body}");
    }
  }
}