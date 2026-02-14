abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfilePicUploading extends ProfileState {} // Show spinner
class ProfilePicUploadSuccess extends ProfileState {
  final String imageUrl;
  ProfilePicUploadSuccess(this.imageUrl);
}
class ProfilePicUploadFailure extends ProfileState {
  final String error;
  ProfilePicUploadFailure(this.error);
}