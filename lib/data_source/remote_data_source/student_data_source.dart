import 'dart:io';
import 'package:batch_student_objbox_api/app/constants.dart';
import 'package:batch_student_objbox_api/helper/http_service.dart';
import 'package:batch_student_objbox_api/model/student.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class StudentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();
  Future<int> addStudent(File? file, Student student) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType("image", mimeType!.split("/")[1]));
      }

      var map = student.toJson();
      map["course"] = student.course.map((course) => course.courseId).toList();
      map["batch"] = student.batch.target!.batchId;
      map["image"] = image;

      FormData formData = FormData.fromMap(map);

      Response res =
          await _httpServices.post(Constant.studentURL, data: formData);
      return res.statusCode == 201 ? 1 : 0;
    } catch (_) {
      return 0;
    }
  }
}
