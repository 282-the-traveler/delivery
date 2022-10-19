import 'package:actual/common/const/colors.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  // image
  final Widget thumbUrl;

  // restaurant name
  final String name;

  // restaurant tags
  final List<String> tags;

  // rating count
  final int ratingsCount;

  // delivery time
  final int deliveryTime;

  // delivery fee
  final int deliveryFee;

  // average rating
  final double ratings;

  // detail
  final bool isDetail;

  // detail description
  final String description;

  const RestaurantCard({
    Key? key,
    required this.thumbUrl,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    required this.description,
  }) : super(key: key);

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      thumbUrl: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratings: model.ratings,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
      description: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isDetail
            ? thumbUrl
            : ClipRRect(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                child: thumbUrl,
              ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDetail ? 16.0 : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                tags.join(
                  '·',
                ),
                style: TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _IconText(
              icon: Icons.star,
              label: ratings.toString(),
            ),
            renderDot(),
            _IconText(
              icon: Icons.receipt,
              label: ratingsCount.toString(),
            ),
            renderDot(),
            _IconText(
              icon: Icons.timelapse_outlined,
              label: '$deliveryTime 분',
            ),
            renderDot(),
            _IconText(
              icon: Icons.monetization_on,
              label: deliveryFee == 0 ? 'Free' : deliveryFee.toString(),
            ),
          ],
        ),
        if (description != '' && isDetail)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Text(
              description,
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

Widget renderDot() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      '·',
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
