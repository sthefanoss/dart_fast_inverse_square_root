import 'dart:math';
import 'dart:typed_data';

extension Float64ListCast on Float64List {
  Int64List get asInt64Buffer => buffer.asInt64List();
}

void main(List<String> arguments) {
  final iterations = 100000000;
  final t1 = DateTime.now();
  for (int i = 0; i < iterations; i++) {
    fastInverseSquareRoot(2);
  }
  final t2 = DateTime.now();
  for (int i = 0; i < iterations; i++) {
    inverseSquareRoot(2);
  }
  final t3 = DateTime.now();
  final diff1 = t2.difference(t1);
  final diff2 = t3.difference(t2);
  print('fastInverseSquareRoot takes $diff1 for $iterations.');
  print('inverseSquareRoot takes $diff2 for $iterations.');
}

double fastInverseSquareRoot(double x) {
  double y = x;
  double x2 = y * 0.5;
  final floatList = Float64List(1)..[0] = y;
  floatList.asInt64Buffer[0] =
      0x5fe6eb50c7b537a9 - (floatList.asInt64Buffer[0] >> 1);
  y = floatList[0];
  y = y * (1.5 - (x2 * y * y)); // 1st iteration
  //y = y * (1.5 - (x2 * y * y)); // 2nd iteration, this can be removed
  return y;
}

double inverseSquareRoot(double x) {
  return 1 / sqrt(x);
}
