void runTest() {
  int a = 10, b = 20;
  swap(a, b);
  print("${a}, ${b}");
}

void swap(int a, int b) {
  a = a + b;
  b = a - b;
  a = a - b;
}
