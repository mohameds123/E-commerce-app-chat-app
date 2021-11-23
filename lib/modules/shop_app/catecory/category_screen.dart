import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/cubit.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/states.dart';
import 'package:flutter_nwesapp/model/categories_home_model.dart';
import 'package:flutter_nwesapp/shared/components/conditional.dart';
class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).shopCategoriesModel!=null,
              builder: ListView.separated(
                itemBuilder:(context,index)=>CategoryListItem(
                  category: ShopCubit.get(context).shopCategoriesModel?.data!.data![index],
                ),
                separatorBuilder:(context,index)=>Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                itemCount: ShopCubit.get(context).shopCategoriesModel!.data!.data!.length,
              ),
              fallback: Center(child: CircularProgressIndicator()),
          );
        }
    );
  }
}
class CategoryListItem extends StatelessWidget {
  ShopCategory? category;
  CategoryListItem({
    this.category,
});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(category!.image),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Text(
                category!.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.arrow_forward_ios,
              size: 16.0,
            ),
          )
        ],
      ),
    );
  }
}