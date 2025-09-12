class GetChat {
  final String content;
  final String role;
  GetChat({required this.content, required this.role});

  factory GetChat.fromJson(Map<String, dynamic> json) {
    return GetChat(
      content: json['content'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'role': role,
      };
}
