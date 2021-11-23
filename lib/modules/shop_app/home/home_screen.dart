import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/cubit.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/states.dart';
import 'package:flutter_nwesapp/model/categories_home_model.dart';
import 'package:flutter_nwesapp/model/shop_home_model.dart';
import 'package:flutter_nwesapp/shared/components/conditional.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: (ShopCubit.get(context).shopHomeModels!=null&&ShopCubit.get(context).shopCategoriesModel!=null),
            fallback: Center(child: CircularProgressIndicator()),
            builder: Column(
              children: [
                CarouselSlider(
                  items: ShopCubit.get(context).shopHomeModels?.data!.banners!.map((e) =>
                      Image(
                        image: NetworkImage(e.image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )).toList(),
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16/9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                      'Categories',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                height: 120.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        itemBuilder:(context,index)=>CategoryItem(
                          category:ShopCubit.get(context).shopCategoriesModel?.data!.data![index],
                        ),
                        separatorBuilder: (context,builder)=>SizedBox(
                        width: 10.0,
                      ),
                        itemCount: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'New Arrivals',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
               GridView.count(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 crossAxisCount: 2,
                 mainAxisSpacing: 1.0,
                 crossAxisSpacing: 1.0,
                 childAspectRatio: 1/1.6,
                 children: List.generate(
                   ShopCubit.get(context).shopHomeModels?.data!.products!.length??0,
                     (index)=>
                         ProductItem(
                           shopProducts: ShopCubit.get(context).shopHomeModels?.data!.products![index],
                         ),
                 ),
               )
              ],
            ),
          );
        },
      ),
    );
  }
}
class CategoryItem extends StatelessWidget {
  ShopCategory? category;
  CategoryItem({
    this.category,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image:NetworkImage(
              category!.image,
            ),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color:Colors.black.withOpacity(.8),
            width: double.infinity,
            child: Text(
              category!.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ProductItem extends StatelessWidget {
  ShopProducts?shopProducts;
  ProductItem({
    this.shopProducts,
});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 5.0,right: 5.0),
      child: Column(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(shopProducts!.image),
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            shopProducts!.name.toString(),
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Text(
                  shopProducts!.price.toString(),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              if(shopProducts!.discount!=0)
              Text(
                shopProducts!.oldPrice.toString(),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: (){
                    ShopCubit.get(context).changeFavoriteData(shopProducts!.id);
                  },
                  icon:ShopCubit.get(context).favoriteList[shopProducts!.id]!?Icon(Icons.favorite):Icon(Icons.favorite_border),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
