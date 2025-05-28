class APIResponse {
  final String id;
  final String url;
  final int width;
  final int height;

  const APIResponse({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'url': String url,
        'width': int width,
        'height': int height,
      } =>
        APIResponse(id: id, url: url, width: width, height: height),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
