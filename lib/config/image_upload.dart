// import 'package:flutter/cupertino.dart';
// import 'package:flutter_image_upload/service.dart';

// import 'package:image_picker/image_picker.dart';


//   void uploadImage(ImageSource imageSource) async {
//     try {
//       final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         var response = await ImageService.uploadFile(pickedFile.path);

//         if (response.statusCode == 200) {
//           //get image url from api response
//           imageURL = response.data['user']['image'];

//           Get.snackbar('Success', 'Image uploaded successfully',
//               margin: EdgeInsets.only(top: 5,left: 10,right: 10));
//         } else if (response.statusCode == 401) {
//           Get.offAllNamed('/sign_up');
//         } else {
//           Get.snackbar('Failed', 'Error Code: ${response.statusCode}',
//               margin: EdgeInsets.only(top: 5,left: 10,right: 10));
//         }
//       } else {
//         Snackbar('Failed', 'Image not selected',
//             margin: EdgeInsets.only(top: 5,left: 10,right: 10));
//       }
//     } finally {
    
//     }
//   }
// }