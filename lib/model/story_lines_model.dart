class StoryLinesModel {
  int? id;
  int? userid;
  int? storyid;
  String? story;

  StoryLinesModel({this.id, this.userid, this.storyid, this.story});

  StoryLinesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    storyid = json['storyid'];
    story = json['story'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['storyid'] = this.storyid;
    data['story'] = this.story;
    return data;
  }
}
