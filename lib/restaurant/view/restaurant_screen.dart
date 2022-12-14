import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
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
          'authorization': 'Bearer $accessToken',
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
                return Center(
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR,
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final parsedItem = RestaurantModel.fromJson(
                      item,
                    );
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(
                              id: parsedItem.id,
                            ),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(
                        model: parsedItem,
                      ),
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
