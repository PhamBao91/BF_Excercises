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
                "RAYA v?? r???ng th???n cu???i c??ng",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Xu???t b???n:   05-T3-2021",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Th??? Loa???: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "Phim Ho???t H??nh, Phim Phi??u L??u, Phim Gi??? T?????ng, Phim Gia ????nh, Phim H??nh ?????ng",
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
            "Raya v?? R???ng Th???n Cu???i C??ng k??? v??? m???t v????ng qu???c huy???n b?? c?? t??n l?? Kumandra ??? v??ng ?????t m?? lo??i r???ng v?? con ng?????i s???ng h??a thu???n v???i nhau. Nh??ng r???i m???t th??? l???c ??en t???i b???ng ??e d???a b??nh y??n n??i ????y, lo??i r???ng bu???c ph???i hi sinh ????? c???u l???y lo??i ng?????i. 500 n??m sau, th??? l???c ???y b???ng tr???i d???y v?? m???t l???n n???a, Raya l?? chi???n binh duy nh???t mang trong m??nh tr???ng tr??ch ??i t??m R???ng Th???n cu???i c??ng trong truy???n thuy???t nh???m h??n g???n l???i kh???i ng???c ???? v??? ????? c???u l???y v????ng qu???c. Th??ng qua cu???c h??nh tr??nh, Raya nh???n ra lo??i ng?????i c???n nhi???u h??n nh???ng g?? h??? ngh??, ???? ch??nh l?? l??ng tin v?? s??? ??o??n k???t.",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
