import 'dart:convert';

import 'package:flutter_in_action_v2/exercise/address.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User(this.name, this.email, this.address);
  String name;
  String email;
  Address address;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
