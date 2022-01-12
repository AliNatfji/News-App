import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/webview/webview.dart';



Widget defaultButton ({
  double width = double.infinity ,
  Color background = Colors.blue,
  bool isUpperCase =true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>  Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed: ()
    {
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle (
        color: Colors.white,
      )
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);



Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function ? onSubmit,
  Function ? onChange,
  Function ? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ? suffix,
  Function ? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onChanged:(s)
      {
        onChange!(s);
      },

      onFieldSubmitted: (s)
      {
        onSubmit!(s);
      },

      onTap:()
      {
        onTap!();
      },

      validator: (s)
      {
        validate();
      },
      decoration:  InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
            onPressed:() {
              suffixPressed!();
            },
            icon : Icon(
              suffix,
            )
        ),
        border: const OutlineInputBorder(),
      ),
    );


Widget buildTaskItem(Map model, context) =>
    Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        // IconButton(
        //   onPressed: ()
        //   {
        //     AppCubit.get(context).updateData(
        //       status: 'done',
        //       id: model['id'],
        //     );
        //   },
        //   icon: const Icon(
        //     Icons.check_box,
        //     color: Colors.green,
        //   ),
        // ),
        // IconButton(
        //   onPressed: () {
        //     AppCubit.get(context).updateData(
        //       status: 'archive',
        //       id: model['id'],
        //     );
        //   },
        //   icon: const Icon(
        //     Icons.archive,
        //     color: Colors.black45,
        //   ),
        // ),
      ],
    ),
  ),
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => BuildCondition(
  condition: tasks.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => myDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);




Widget buildArticleItem(article,context) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list,context,{isSearch = false}) => BuildCondition(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index],context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,),
        fallback: (context) =>
        isSearch  ? Container() :const Center( child: CircularProgressIndicator(),),
);


void navigateTo (context,widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
