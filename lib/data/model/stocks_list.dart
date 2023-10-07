import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StocksList {
  final List<Stock> data;
  StocksList({this.data = const <Stock>[]});

  StocksList copyWith({List<Stock>? data}) =>
      StocksList(data: data ?? this.data);

  dynamic toJson() => data.map((x) => x.toJson()).toList();

  factory StocksList.fromJson(dynamic json) => StocksList(
      data: List<Stock>.from(
          (json as List<dynamic>?)?.map<Stock>((x) => Stock.fromJson(x)) ??
              <Stock>[]));

  // factory StocksList.fromJson(String source) => StocksList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StocksList(data: $data)';

  @override
  bool operator ==(covariant StocksList other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}

extension ColorParser on String {
  Color? get tryParseColor => this == "green"
      ? Colors.green
      : this == "red"
          ? Colors.red
          : null;

  CriteriaType? get tryParseCriteriaType => toLowerCase() == "plain_text"
      ? CriteriaType.plainText
      : this == "variable"
          ? CriteriaType.variable
          : null;
  VariableType? get tryParseVariableType => toLowerCase() == "value"
      ? VariableType.value
      : toLowerCase() == "indicator"
          ? VariableType.indicator
          : null;
}

extension ColorToText on Color {
  String? get colorName => this == Colors.green
      ? "green"
      : this == Colors.red
          ? "red"
          : null;
}

class Stock {
  final int id;
  final String name;
  final String tag;
  final Color? color;
  final List<Criteria> criteria;
  Stock({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  Stock copyWith({
    int? id,
    String? name,
    String? tag,
    Color? color,
    List<Criteria>? criteria,
  }) {
    return Stock(
      id: id ?? this.id,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      color: color ?? this.color,
      criteria: criteria ?? this.criteria,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag": tag,
        "color": color?.colorName,
        "criteria": criteria.map((e) => e.toJson()).toList()
      };

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        id: json["id"] as int,
        name: json['name'] as String,
        tag: json['tag'] as String,
        color: (json['color'].toString()).tryParseColor,
        criteria: List<Criteria>.from(
          (json['criteria'] as List).map<Criteria>(
            (x) => Criteria.fromJson(x),
          ),
        ),
      );

  @override
  String toString() {
    return 'Stock(id: $id, name: $name, tag: $tag, color: $color, criteria: $criteria)';
  }

  @override
  bool operator ==(covariant Stock other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.tag == tag &&
        other.color == color &&
        listEquals(other.criteria, criteria);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        tag.hashCode ^
        color.hashCode ^
        criteria.hashCode;
  }
}

enum CriteriaType { plainText, variable }

extension CriteriaTypeExtension on CriteriaType {
  String? get text {
    switch (this) {
      case CriteriaType.plainText:
        return 'plain_text';
      case CriteriaType.variable:
        return 'variable';
      default:
        return null;
    }
  }
}

class Criteria {
  final CriteriaType type;
  final String text;
  final Map<String, Variable?>? variable;
  Criteria({
    required this.type,
    required this.text,
    this.variable,
  });

  Criteria copyWith({
    CriteriaType? type,
    String? text,
    Map<String, Variable?>? variable,
  }) {
    return Criteria(
      type: type ?? this.type,
      text: text ?? this.text,
      variable: variable ?? this.variable,
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type.text,
        "variable": variable,
      };

  factory Criteria.fromJson(Map<String, dynamic> json) => Criteria(
        text: json["text"] as String,
        type: json["type"].toString().tryParseCriteriaType ??
            CriteriaType.plainText,
        variable: (json["variable"] as Map<String, dynamic>?)
                ?.map<String, Variable>(
                    (key, value) => MapEntry(key, Variable.fromJson(value))) ??
            <String, Variable>{},
      );

  @override
  String toString() =>
      'Criteria(type: $type, text: $text, variable: $variable)';

  @override
  bool operator ==(covariant Criteria other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.text == text &&
        mapEquals(other.variable, variable);
  }

  @override
  int get hashCode => type.hashCode ^ text.hashCode ^ variable.hashCode;
}

enum VariableType { value, indicator }

extension VariableTypeToText on VariableType {
  String? get text => this == VariableType.indicator
      ? "indicator"
      : this == VariableType.value
          ? "value"
          : null;
}

class Variable {
  final VariableType? type;
  final List<num>? values;
  final String? studyType;
  final String? parameterName;
  final num? minValue;
  final num? maxValue;
  final num? defaultValue;
  Variable({
    required this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  Variable copyWith({
    VariableType? type,
    List<num>? values,
    String? studyType,
    String? parameterName,
    int? minValue,
    int? maxValue,
    int? defaultValue,
  }) {
    return Variable(
      type: type ?? this.type,
      values: values ?? this.values,
      studyType: studyType ?? this.studyType,
      parameterName: parameterName ?? this.parameterName,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      defaultValue: defaultValue ?? this.defaultValue,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type?.text,
      'values': values,
      'studyType': studyType,
      'parameterName': parameterName,
      'minValue': minValue,
      'maxValue': maxValue,
      'defaultValue': defaultValue,
    };
  }

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(
      type: json['type'].toString().tryParseVariableType,
      values: (json['values'] as List?)?.map((e) => e as num).toList(),
      studyType: json['study_type'] as String?,
      parameterName: json['parameter_name'] as String?,
      minValue: json['min_value'] as int?,
      maxValue: json['max_value'] as int?,
      defaultValue: json['default_value'] as int?,
    );
  }

  @override
  String toString() {
    return 'Variable(type: $type, values: $values, studyType: $studyType, parameterName: $parameterName, minValue: $minValue, maxValue: $maxValue, defaultValue: $defaultValue)';
  }

  @override
  bool operator ==(covariant Variable other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        listEquals(other.values, values) &&
        other.studyType == studyType &&
        other.parameterName == parameterName &&
        other.minValue == minValue &&
        other.maxValue == maxValue &&
        other.defaultValue == defaultValue;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        values.hashCode ^
        studyType.hashCode ^
        parameterName.hashCode ^
        minValue.hashCode ^
        maxValue.hashCode ^
        defaultValue.hashCode;
  }
}
