import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../global_function.dart';

// Future<String> pickProfileImage() async {
//   ImagePicker picker = ImagePicker();
//   File file = await pickProfilePicture(ImageSource.gallery);
//   File decompressImage = await compressToJpeg(file);
//   String fileExtension = decompressImage.path.split(".").last;
//   List<int> imageBytes = decompressImage.readAsBytesSync();

//   String base64File = base64Encode(imageBytes);

//   // _profileImage?.value = File(file.path);

//   var header = {
//     "Content-Type": "application/json",
//   };

//   http
//       .post(
//     Uri.parse("http://cubelean.com:8888/api/v1/s3/upload"),
//     headers: header,
//     body: jsonEncode({
//       "data": [base64File],
//       "extension": [fileExtension],
//       "thumbnail": false,
//     }),
//   )
//       .then((res) async {
//     var result = await jsonDecode(res.body);
//     // print(jsonEncode(result));

//     print(result[0]);

//     return result[0];
//   }).catchError((err) {
//     print("ImageUploadError :: " + err.toString());

//     return "";
//   });
// }

Future<File> pickProfilePicture(ImageSource source) async {
  ImagePicker picker = ImagePicker();
  var imageFile = await picker.getImage(
    source: source,
  );
  if (imageFile == null) {
    return null;
  }

  var croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    maxHeight: 1080,
    maxWidth: 1080,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    // androidUiSettings: AndroidUiSettings(
    //     toolbarTitle: '',
    //     toolbarColor: HexColor.fromHex("#ff7070"),
    //     toolbarWidgetColor: Colors.white,
    //     initAspectRatio: CropAspectRatioPreset.original,
    //     lockAspectRatio: true),
    // iosUiSettings: IOSUiSettings(
    //   // minimumAspectRatio: 1.0,
    //   title: 'Cropper',
    // ),
  );
  var file = File.fromUri(Uri.parse(croppedFile.path));
  return file;
}

Future<File> compressToJpeg(
  File file,
) async {
  final dir = await getTemporaryDirectory();
  final tempName = Uuid().v4();
  final targetPath = dir.absolute.path + "/$tempName.jpg";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    format: CompressFormat.jpeg,
    autoCorrectionAngle: true,
    keepExif: true,
    quality: 100,
  ).catchError((onError) {});

  var decodedImage = await decodeImageFromList(result.readAsBytesSync())
      .catchError((onError) {});

  String name = Uuid().v4() + "img";
  int minHeight = 1350;
  int minWidth = 1080;
  String orientation;
  if (decodedImage.width == decodedImage.height) {
    minHeight = 1080;
    minWidth = 1080;
    orientation = "se";
  } else {
    if (decodedImage.width > decodedImage.height) {
      minHeight = 680;
      minWidth = 1080;
      orientation = "lse";
    } else {
      minHeight = 1350;
      minWidth = 1080;
      orientation = "ptt";
    }
  }

  final myPath = dir.absolute.path + "/$name-cmp-$orientation.jpg";
  var finalResult = await FlutterImageCompress.compressAndGetFile(
    result.absolute.path,
    myPath,
    format: CompressFormat.jpeg,
    autoCorrectionAngle: true,
    keepExif: true,
    minWidth: minWidth,
    minHeight: minHeight,
    quality: 50,
  ).catchError((onError) {});

  return finalResult;
}
