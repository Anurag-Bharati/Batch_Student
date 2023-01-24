import 'package:batch_student_objbox_api/model/student.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

// part 'batch_response.g.dart'

//flutter pub run build_runner build  --delete-conflicting-outputs

@Entity()
@JsonSerializable()
class Batch {
  // @Id(assignable: true)
  @Id(assignable: true)
  int id;

  @Unique()
  @JsonKey(name: "_id")
  String? batchId;
  String batchName;

  @Backlink()
  final student = ToMany<Student>();

  //Constructor
  Batch(this.batchId, this.batchName, {this.id = 0});
  // Batch(this.batchId, this.batchName);

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(json['_id'], json['batchName']);
  }

  Map<String, dynamic> toJson() => {'_id': batchId, 'batchName': batchName};
}
