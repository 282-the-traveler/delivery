import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> pagenateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(
      key: ACCESS_TOKEN_KEY,
    );
    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Barer $accessToken',
        },
      ),
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: FutureBuilder<List>(
            future: pagenateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    return RestaurantCard(
                      image: Image.network(
                        'http://$ip${item['thumbURL']}',
                        fit: BoxFit.cover,
                      ),
                      name: item['name'],
                      tags: List<String>.from(item['tags']),
                      ratingsCount: item['ratingsCount'],
                      deliveryTime: item['deliveryTime'],
                      deliveryFee: item['deliveryFee'],
                      ratings: item['ratings'],
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      height: 16.0,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
