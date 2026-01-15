# # use std.io
# # use std.math


# # PRINT
# print(10);
# print(true);
# print("hello world");
# print(10 + 5);
# print(10 - 2);
# print(10 * 4);
# print(10 / 2);
# print(10 * 4 / 2 + 1);
# print(10 % 3);
# print(!!!false);
# print(!!-8 * 3);












# # DECLARATION
# var x = 888;
# var y = 9987;
# print(x);
# print(y);
# var sum = x + y;
# print(sum);

# var z = "coba string";
# print(z);

# var contohBool = false;
# print(contohBool);









# # ASSIGNMENT
# var assign1 = "hemm";
# print(assign1);

# var assign2;
# print(assign2);
# assign2 = true;
# print(assign2);
# assign2 = 10;
# print(assign2);
# assign2 = "wello";
# print(assign2);
# assign2 = assign1;
# print(assign2);

# var assignDecl = assign1;
# print(assignDecl);
# assign1 =  "ganti assign1";
# print(assign1);
# print(assignDecl);

# # print(10.5);
# # var float = 10.5 + 2.3;
















# # CONDITION
# var first = 90;
# var second = 90;
# var isSmall = first < second;

# print(first < second);
# print(isSmall);

# print(10 == 5);
# print(first == second);
# print(first != second);

# print(first >= second);
# print(first <= second);

# if(10 > 5){
#     print("44444");
# }


# if(10 < first){
#     print("oi");
# }














# var nilai = 100;

# if(nilai != 10){
#     print("muehehehehe");
# }
# elif(nilai == 9){
#     print("elif");
# }
# elif(nilai == 7){
#     print("elif2");
# }
# elif(nilai == 99){
#     print("elif3");
# }
# else {
#     print("else");
#     var m = 99;
#     print(m);
# }
















# # LOOPING
# for i = 0 .. 2 {
#     print(i);
# }

# for i = 0 .. 6, 2 {
#     print(i);
# }


# for i = 5 .. -1, 2 {
#     print(i);
# }


# for i = 10 .. 12 {
#     for j = 10 .. 12 {
#         var z = 99;
#         print(j);
#     }
# }


# var coba = 4;

# for i = 0 .. coba {
#     print(i);
# }


# # for i = coba .. 0 { # ini blm
# #     print(coba);
# # }

# for i = 0 .. 2 {
#     print(i);
#     if(i == 0){
#         print("ini 0");
#     }
# }

# for i = 0 .. 2 {
#     for j = 0 .. 2 {
#         if(j == 1){
#             print(j);
#             var inner = "hello inner";
#             print(inner);
#         }
#         else {
#             print("hemm");
#         }
#     }
# }
















# # FUNCTION NO RETURN
# fun displayHello(){
#     print("mellow");
#     for i = 0 .. 2 {
#         for j = 3 .. 5 {
#             if(i == 1){
#                 print(j);
#             }
#         }
#     }

#     var m = 99;
#     print(m);
# }
# displayHello();

# fun callWithParam(param1){
#     print(param1);
# }

# callWithParam("hello");
# callWithParam(10);

# fun addParams(a, b){
#     print(a + b);
# }
# addParams(10, 30);



# fun diffTyParam(first, second){
#     print(first);
#     print(second);
# }

# diffTyParam(10, "apa ya");
# diffTyParam("apa ya", 10);






























# # FUNCTION RETURN
# fun ret5(){
#     return 5;
# }
# var five = ret5();
# print(five);

# print(ret5());


# fun resBinOp(a, b){
#     return 5 + a * 7 / 2 - b;
# }
# print(resBinOp(6, 2));


# fun retStr(){
#     return "gello";
# }

# var getGello = retStr();
# print(getGello);

# print(retStr());









# # return variable
# fun retParam1(){
#     var a = 9;
#     return a;
# }
# print(retParam1()); 
# var retParam1Res = retParam1();
# print(retParam1Res);


# fun retParam2(a){
#     return a;
# }
# print(retParam2(10)); 
# var retParam2Res = retParam2(10);
# print(retParam2Res);

# print(retParam2("woi"));

# var arg = 99; # ini error
# fun retParam3(a){
#     return a;
# }
# print(retParam3(arg));
# var retParam3Res = retParam3(arg);
# print(retParam3Res);



# fun retParam4(a){
#     return a;
# }
# print(retParam4(arg + 1)); 
# var retParam4Res = retParam4(arg + 1);
# print(retParam4Res);




# fun retParam5(a){
#     return a + 1 * 9; # error
# }
# print(retParam5(arg)); 
# print(arg);
# var retParam5Res = retParam5(arg);
# print(retParam5Res);
# print(arg);






# fun retLocal(a){
#     var b = 9;
#     return a + b;
# }
# print(retLocal(8));
# var retLocalVar = retLocal(1);
# print(retLocalVar);



# var arg2 = 9;
# fun retLocal2(a){
#     var b = 9;
#     return a + b;
# }
# print(retLocal2(arg2));
# var retLocalVar2 = retLocal2(1);
# print(retLocalVar2);












# # INPUT
# fun tesFunInput(){
#     var inputStr = input("Masukkan string: ");
#     print(inputStr);

#     var inputInt = input("Masukkan angka: ") as int;
#     print(inputInt);
# }

# tesFunInput();









# # TYPEOF
# var tipeInt = 10;
# print(typeof(tipeInt));


# tipeInt = "jadi str";
# print(typeof(tipeInt));

# tipeInt = true;
# print(typeof(tipeInt));



# # USE
# use std.math

# print(math_abs(-79));




# # Array
# var arr = [9 .. 15, 97, 43, 35, 42, 75];
# print(arr[5]);

# var idx = 2;
# print(arr[idx]);


# print(arr[0]);
# arr[0] = 777;

# print(arr[0]);



var arr2 = [10, 11];
arr2[2] = 5;
print(arr2[2]);

