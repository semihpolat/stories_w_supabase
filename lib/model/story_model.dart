class StoryModel {
  List<StoryLines>? storyLines;

  StoryModel({this.storyLines});

  StoryModel.fromJson(Map<String, dynamic> json) {
    if (json['storyLines'] != null) {
      storyLines = <StoryLines>[];
      json['storyLines'].forEach((v) {
        storyLines!.add(new StoryLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storyLines != null) {
      data['storyLines'] = this.storyLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryLines {
  int? userId;
  int? storyId;
  String? story;
  String? color;

  StoryLines({this.userId, this.storyId, this.story, this.color});

  StoryLines.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    storyId = json['storyId'];
    story = json['story'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['storyId'] = this.storyId;
    data['story'] = this.story;
    data['color'] = this.color;
    return data;
  }
}
