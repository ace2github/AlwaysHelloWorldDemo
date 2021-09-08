import 'FunctionDemo.dart';
import 'ClassDemo.dart';

void main(List<String> args) {
  String slogan = 'hello haha';
  var dataList = <String>[slogan];
  dataList.insert(0, '123456');
  print(dataList);

  // var name;
  // print(name);

  // String nickName;
  // print(nickName); // 报错，不可为空变量，使用前必须初始化

  // String? nickName1;
  // print(nickName1); // 不会报错，null

  // int num = 1;
  // print("%x", num);

  // var list = [1, 2, 3];
  // printArray(list);
  // sayHelloworld('cch');
  class_demo_test();

  // testFunctionHandler();

  // var foo = const [];
  // foo = [1, 2, 3];
  // print(foo);
  // foo[0] = 0;
  // print(foo);

  // foo = [2, 3, 4];
  // print(foo);

  // var list = [1, 2, 3];
  // var list2 = [0, ...list];
  // print(list2); // [0, 1, 2, 3]

  // var null_list;
  // var list3 = [0, ...?null_list];
  // print(list3); // [0]

  // bool promoActive = true;
  // var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  // print(nav); // [Home, Furniture, Plants, Outlet]

  // var listOfInts = [1, 2, 3];
  // var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  // print(listOfStrings); // [#0, #1, #2, #3]
}
