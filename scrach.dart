import 'dart:io';
void main(){
performTask();
}
void performTask(){
task1();
task2();
task3();
}
void task1(){
String result = "1";
print(result);
}
void task2()async{
  Duration threeseconds = Duration(seconds: 3);
  Future.delayed(threeseconds,(){
    String result = "2";
    print(result);
  });
}

void task3(){

  String result = "3";
  print(result);
}