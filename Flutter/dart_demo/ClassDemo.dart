void class_demo_test() {
  Point p = new Point(16, 18);
  print('TEST：${p.runtimeType} ${p.x} ${p.y} ${p.desc}');
  print('\n');

  Point p1 = new Point.SomeInfo('hello');
  print('TEST：${p1.runtimeType} ${p1.x} ${p1.y} ${p1.desc}');
  print('\n');

  Person user = Person();
  user.name = "CCH";
  print(user.name);
  print(user.runtimeType);

  modifyName('test', user);
  print(user.name);

  modifyName('hui', user);
  print(user.name);
}

class HelloClass extends Object {
  String? name;
  int age = 0;
}

class Point extends Object {
  double x = 0;
  double y = 0;
  String desc;

  // 默认构造函数，包含默认值
  Point(this.x, this.y, {this.desc = 'default'});

  // 命名构造函数
  Point.SomeInfo(String text) : desc = text;
}

// class HelloPoint extends Point {
//   double z = 0;

//   HelloPoint(double x, double y) : super(x, y);
// }

void modifyName(String name, Person info) {
  info.name = name;
}

void printString(String name) {
  print(name);
}

void printArray(List arr) {
  for (int i = 0; i < arr.length; i++) {
    print(arr[i]);
  }
}

class Person extends Object {
  String name = '';
}
