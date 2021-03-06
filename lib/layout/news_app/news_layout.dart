import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/search/search.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                    Icons.search
                ),
                onPressed:()
                {
                  navigateTo(context, SearchScreen(),);
                },
              ),
              IconButton(
                icon: const Icon(
                    Icons.brightness_6_outlined,
                ),
                onPressed:()
                {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
              print('the index :' + index.toString());
            },
            items:cubit.bottomItems,
          ),
        );
      }
    );
  }
}
