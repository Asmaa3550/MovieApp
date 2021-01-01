import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ActorListTile extends StatelessWidget {
  final name;
  final imageUrl;
  ActorListTile({this.imageUrl, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 55.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                width: 180.0,
                height: 200.0,
                imageUrl: imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(),
            width: 120.0,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600 , color: Colors.white60),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
