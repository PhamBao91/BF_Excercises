import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_test_app/model/item_cast.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background1.jpeg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.8),
          ),
          _body(context)
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(
          height: 20,
        ),
        _header(),
        SizedBox(
          height: 20,
        ),
        _cast(),
        SizedBox(
          height: 20,
        ),
        _overview()
      ],
    );
  }

  _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 113,
            height: 153,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/image1.jpeg"))),
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "RAYA và rồng thần cuối cùng",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Xuất bản:   05-T3-2021",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thể Loaị: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "Phim Hoạt Hình, Phim Phiêu Lưu, Phim Giả Tượng, Phim Gia Đình, Phim Hành Động",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _cast() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cast",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 160,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listItemCast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _itemCast(listItemCast[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  _itemCast(ItemCast itemCast) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Expanded(
              child: Container(
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(itemCast.urlPhoto))),
          )),
          SizedBox(
            height: 4,
          ),
          Text(
            itemCast.name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            itemCast.character,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  _overview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Raya và Rồng Thần Cuối Cùng kể về một vương quốc huyền bí có tên là Kumandra – vùng đất mà loài rồng và con người sống hòa thuận với nhau. Nhưng rồi một thế lực đen tối bỗng đe dọa bình yên nơi đây, loài rồng buộc phải hi sinh để cứu lấy loài người. 500 năm sau, thế lực ấy bỗng trỗi dậy và một lần nữa, Raya là chiến binh duy nhất mang trong mình trọng trách đi tìm Rồng Thần cuối cùng trong truyền thuyết nhằm hàn gắn lại khối ngọc đã vỡ để cứu lấy vương quốc. Thông qua cuộc hành trình, Raya nhận ra loài người cần nhiều hơn những gì họ nghĩ, đó chính là lòng tin và sự đoàn kết.",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
