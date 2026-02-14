import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frisky_fruits/features/profiles/bloc/profile_event.dart';
import 'package:frisky_fruits/features/profiles/bloc/profile_state.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  final ImagePicker _picker = ImagePicker();

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<UpdateProfilePicRequested>((event, emit) async {
      emit(ProfilePicUploading());

      try {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );

        if (image == null) {
          emit(ProfileInitial());
          return;
        }

        // 👈 FIXED: Pass the 'image' (XFile) object, not 'image.path'
        final String imageUrl = await repository.uploadToCloudinary(image);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.uid)
            .update({
          'profilePic': imageUrl,
        });

        emit(ProfilePicUploadSuccess(imageUrl));
      } catch (e) {
        emit(ProfilePicUploadFailure(e.toString()));
      }
    });
  }
}