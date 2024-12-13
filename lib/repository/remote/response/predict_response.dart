class PredictResponse {
  final bool success;
  final String message;
  final PredictionData? data;

  PredictResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory PredictResponse.fromJson(Map<String, dynamic> json) {
    return PredictResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? PredictionData.fromJson(json['data']) : null,
    );
  }
}

class PredictionData {
  final Prediction prediction;
  final String tips;
  final int resultId;
  final String photoUrl;

  PredictionData({
    required this.prediction,
    required this.tips,
    required this.resultId,
    required this.photoUrl,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    return PredictionData(
      prediction: Prediction.fromJson(json['prediction']),
      tips: json['tips'],
      resultId: json['result_id'],
      photoUrl: json['photo_url'],
    );
  }
}

class Prediction {
  final String category;
  final double confidence;

  Prediction({
    required this.category,
    required this.confidence,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      category: json['category'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
