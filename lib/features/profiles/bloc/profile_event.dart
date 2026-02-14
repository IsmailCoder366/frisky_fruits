abstract class ProfileEvent {}
class UpdateProfilePicRequested extends ProfileEvent {
  final String uid;
  UpdateProfilePicRequested(this.uid);
}