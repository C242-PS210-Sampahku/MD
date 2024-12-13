class HistoryPredictionResponse {
  final bool success;
  final String message;
  final int currentPage;
  final int totalData;
  final int totalPage;
  final List<HistoryData> data;

  HistoryPredictionResponse({
    required this.success,
    required this.message,
    required this.currentPage,
    required this.totalData,
    required this.totalPage,
    required this.data,
  });

  factory HistoryPredictionResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<HistoryData> dataList = list.map((i) => HistoryData.fromJson(i)).toList();

    return HistoryPredictionResponse(
      success: json['success'],
      message: json['message'],
      currentPage: json['current_page'],
      totalData: json['total_data'],
      totalPage: json['total_page'],
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'current_page': currentPage,
      'total_data': totalData,
      'total_page': totalPage,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }
}

class HistoryData {
  final int historyId;
  final int resultId;
  final String userId;
  final Result result;

  HistoryData({
    required this.historyId,
    required this.resultId,
    required this.userId,
    required this.result,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      historyId: json['history_id'],
      resultId: json['result_id'],
      userId: json['user_id'],
      result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history_id': historyId,
      'result_id': resultId,
      'user_id': userId,
      'result': result.toJson(),
    };
  }
}

class Result {
  final int resultId;
  final String imgUrl;
  final Prediction predict;

  Result({
    required this.resultId,
    required this.imgUrl,
    required this.predict,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      resultId: json['result_id'],
      imgUrl: json['img_url'],
      predict: Prediction.fromJson(json['predict']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result_id': resultId,
      'img_url': imgUrl,
      'predict': predict.toJson(),
    };
  }
}

class Prediction {
  final String category;
  final String suggestion;

  Prediction({
    required this.category,
    required this.suggestion,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      category: json['category'],
      suggestion: json['suggestion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'suggestion': suggestion,
    };
  }
}
