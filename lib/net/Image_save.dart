

// DocumentReference sightingRef = Firestore.instance.collection("profile_image").doc();

// await saveImages(_images,sightingRef);
// Future<void> saveImages(List<File> _images, DocumentReference ref) async {
//   _images.forEach((image) async {
//     String imageURL = await uploadFile(image);
//     ref.update({"images": FieldValue.arrayUnion([imageURL])});
//   });
// }