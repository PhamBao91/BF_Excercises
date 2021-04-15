class VideoList {
  String code;
  String msg;
  List list ;

  VideoList({this.code, this.msg, this.list});

  toJson(){
    return {
      "code": this.code,
      "msg": this.msg,
      "list": this.list,
    };

  }

  factory VideoList.FromJson(json)
  {
    return VideoList(
      code: json['code'],
      msg: json['msg'],
      list: json['list']
    );
  }

}

class VideoModel{
   int id;
   String title;
   String author;
   String description;
   int id_category;
   String name_category;
   String information_category;
   String type;
   String url_video;
   String url_youtube;
   String url_photo;
   String week_day_number;

  VideoModel({this.id, this.title, this.author, this.description, this.id_category, this.name_category, this.information_category, this.type, this.url_video, this.url_youtube, this.url_photo, this.week_day_number});

  toJson(){
    return {
      "id": this.id,
      "title": this.title,
      "author": this.author,
      "description": this.description,
      "id_category": this.id_category,
      "name_category": this.name_category,
      "information_category": this.information_category,
      "type": this.type,
      "url_video": this.url_video,
      "url_youtube": this.url_youtube,
      "url_photo": this.url_photo,
      "week_day_number": this.week_day_number
    };
  }
  factory VideoModel.fromJson(json){
    return VideoModel(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        description: json['description'],
        id_category: json['id_category'],
        name_category: json['name_category'],
        information_category: json['information_category'],
        type: json['type'],
        url_video: json['url_video'],
        url_youtube: json['url_youtube'],
        url_photo: json['url_photo'],
        week_day_number: json['week_day_number']
    );

  }

}