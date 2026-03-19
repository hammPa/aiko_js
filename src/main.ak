# # use std.io
# # use std.math


# # PRINT
# print("===== START PRINT =====");
# print(10);
# print(true);
# print("hello world");
# print(10 + 5);                  # 15
# print(10 - 2);                  # 8
# print(10 * 4);                  # 40
# print(10 / 2);                  # 5
# print(10 * 4 / 2 + 1);          # 21
# print(10 % 3);                  # 1
# print(!false);
# print(-8);                      # -8 (bisa dalam versi masih unsigned)
# print(!!!false);                # 1
# print(!!-8 * 3);                # 3
# print("===== END PRINT =====");











# # DECLARATION
# print("===== START DECLARATION =====");
# var x = 888;
# var y = 9987;
# print(x);                       # 888
# print(y);                       # 9987
# var sum = x + y;
# print(sum);                     # 10875

# var z = "coba string";
# print(z);

# var contohBool = false;
# print(contohBool);
# print("===== END DECLARATION =====");








# # ASSIGNMENT
# print("===== START ASSIGN =====");
# var assign1 = "hemm";
# print(assign1);                 # hemm

# var assign2;
# print(assign2);                 # 0
# assign2 = true;
# print(assign2);                 # 1
# assign2 = 10;
# print(assign2);                 # 10
# assign2 = "wello";
# print(assign2);                 # wello
# assign2 = assign1;
# print(assign2);                 # hemm

# var assignDecl = assign1;
# print(assignDecl);              # hemm
# assign1 =  "ganti assign1";
# print(assign1);                 # ganti assign
# print(assignDecl);              # hemm

# # print(10.5);
# # var float = 10.5 + 2.3;
# print("===== END ASSIGN =====");















# # CONDITION
# print("===== START IF =====");
# var first = 90; 
# var second = 90;
# var isSmall = first < second;

# print(first < second);          # 0
# print(isSmall);                 # 0

# print(10 == 5);                 # 0
# print(first == second);         # 1
# print(first != second);         # 0

# print(first >= second);         # 1
# print(first <= second);         # 1

# if(10 > 5){
#     print("44444");             # 4444
# }


# if(10 < first){
#     print("oi");                # oi
# }














# var nilai = 100;                # else 99

# if nilai == 10 {
#     print("muehehehehe");
# }
# elif nilai == 9 {
#     print("elif");
# }
# elif nilai == 7 {
#     print("elif2");
# }
# elif nilai == 99 {
#     print("elif3");
# }
# else {
#     print("else");
#     var m = 99;
#     print(m);
# }
# print("===== END IF =====");















# # LOOPING
# print("===== START FOR =====");
# for i = 888 .. 890 {
#     print(i);
# }

# for i = 444 .. 450, 2 {        # 444 446 448
#     print(i);
# }

# for i = 5 .. -1 {              # 5 4 3 2 1 0
#     print(i);
# }

# for i = 49 .. -10, 20 {        # 49 29 9
#     print(i);
# }


# for i = 10 .. 12 {
#     for j = 10 .. 12 {
#         var z = 99;
#         print(z);               # 99 99 99 99
#     }
# }


# var coba = 400;

# for i = 0 .. coba, 100 {             # 0 100 200 300
#     print(i);
# }


# for i = coba .. 0, 200 {
#     print(i);                # 400 200
# }

# var updatenya = 5;
# for i = 555 .. 600, updatenya {
#     print(i);
# }

# for i = 0 .. 2 {               # 0 "ini 0" 1
#     print(i);
#     if(i == 0){
#         print("ini 0");
#     }
# }

# for i = 0 .. 2 {                # hemm 1 "hello inner" 2x
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
# print("===== END FOR =====");









# # BREAK CONTINUE
# print("===== START BREAK CONTINUE =====");
# for i = 200 .. 205 {
#     if(i == 203){ break; }              # 200 201 202
#     print(i);
# }

# for i = 300 .. 305 {
#     if(i == 303){ continue; }           # 300 301 301 302 304
#     print(i);
# }
# print("===== END BREAK CONTINUE =====");















# # FUNCTION NO RETURN
# print("===== START FUNC NO RETURN =====");
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
# displayHello();                 # mellow 3 4 99

# fun callWithParam(param1){
#     print(param1);
# }

# callWithParam("hello");         # hello
# callWithParam(10);              # 10

# fun addParams(a, b){
#     print(a + b);
# }
# addParams(10, 30);              # 40



# fun diffTyParam(first, second){
#     print(first);
#     print(second);
# }

# diffTyParam(10, "apa ya");      # 10 "apa ya"
# diffTyParam("apa ya", 10);      # "apa ya" 10
# print("===== END FUNC NO RETURN =====");





























# # FUNCTION RETURN
# print("===== START FUNC RETURN LITERAL =====");
# fun ret5(){
#     return 5;
# }
# var five = ret5();
# print(five);                    # 5

# print(ret5());                  # 5


# fun resBinOp(a, b){
#     return 5 + a * 7 / 2 - b;
# }
# print(resBinOp(6, 2));          # 24


# fun retStr(){
#     return "gello";
# }

# var getGello = retStr();
# print(getGello);                # gello

# print(retStr());                # gello
# print("===== END FUNC RETURN LITERAL =====");








# # return variable
# print("===== START FUNC RETURN VAR ARG =====");
# fun retParam1(){
#     var a = 9;
#     return a;
# }
# print(retParam1());             # 9
# var retParam1Res = retParam1();
# print(retParam1Res);            # 9


# fun retParam2(a){
#     return a;
# }
# print(retParam2(10));           # 10
# var retParam2Res = retParam2(10);
# print(retParam2Res);            # 10

# print(retParam2("woi"));        # woi

# var arg = 99;
# fun retParam3(a){
#     return a;
# }
# print(retParam3(arg));          # 99
# var retParam3Res = retParam3(arg);
# print(retParam3Res);            # 99



# fun retParam4(a){
#     return a;
# }
# print(retParam4(arg + 1));      # 100
# var retParam4Res = retParam4(arg + 1);
# print(retParam4Res);            # 100




# fun retParam5(a){
#     return a + 1 * 9;
# }
# print(retParam5(arg));          # 108
# print(arg);                     # 99
# var retParam5Res = retParam5(arg);
# print(retParam5Res);            # 108
# print(arg);                     # 99
# print("===== END FUNC RETURN VAR ARG =====");





# print("===== START FUNC RETURN VAR LOCAL =====");
# fun retLocal(a){
#     var b = 9;
#     return a + b;
# }
# print(retLocal(8));             # 17
# var retLocalVar = retLocal(1);
# print(retLocalVar);             # 10



# var arg2 = 9;
# fun retLocal2(a){
#     var b = 9;
#     return a + b;
# }
# print(retLocal2(arg2));         # 18
# var retLocalVar2 = retLocal2(1);
# print(retLocalVar2);            # 10
# print("===== END FUNC RETURN VAR LOCAL =====");











# # INPUT
# print("===== START INPUT =====");
# fun tesFunInput(){
#     var inputStr = input("Masukkan string: ");
#     print(inputStr);

#     var inputInt = input("Masukkan angka: ") as int;
#     print(inputInt);
# }

# tesFunInput();
# print("===== END INPUT =====");









# # TYPEOF
# print("===== START TYPEOF USE =====");
# var tipeInt = 10;
# print(typeof(tipeInt));         # 0 (int)


# tipeInt = "jadi str";
# print(typeof(tipeInt));         # 1 (string)

# tipeInt = true;
# print(typeof(tipeInt));         # 2 (bool)



# # USE
# use std.math

# print(abs(-79));                  # 79
# print(min(8, 7));                 # 7
# print(max(8, 7));                 # 8
# print("===== END TYPEOF USE =====");









# # Array
# print("===== START ARRAY =====");
# var arr = [9 .. 15, 97, 43, 35, 42, 75];
# print(arr[5]);                    # 14

# var idx = 2;
# print(arr[idx]);                  # 11


# print(arr[0]);                    # 9
# arr[0] = 777;
# print(arr[0]);                    # 777

# arr[idx] = 25464;
# print(arr[idx]);                  # 25464


# var arr2 = [88, 65];
# # print(arr2[7]); # berhasil out of bonds ketiganya
# # arr2[6] = 5;
# # arr2[idx] = 5;


# print("===== END ARRAY =====");







# # FOR IN
# print("===== START FOR IN =====");
# var arr3 = [666, 444, 222, 999];

# for item in arr3 {
#     print(item);
# }

# for item in arr3 when item > 500 {
#     print(item);
# }

# for item in arr3 when item < 500 {
#     print(item);
# }

# var arr4 = ["string ini woi", true, 444, 863];
# print(arr4[0]);

# for i = 0 .. 4 {
#     print(arr4[i]);
# }
# print("===== END FOR IN =====");




# # RECURSIVE
# fun rec(n){
#     if(n == 1){ return 1; }
#     return n * rec(n - 1);
# }
# print(rec(5));





# # var arr = [0 .. 524287]; # habiskan 4 mb

# # TES
# print("===== START TES PERFORMA =====");
# # var limit = 1000000; # 1jt
# var limit = 1000000000; # 1miliar
# var count = 0;

# for i = 0 .. limit {
#     count = count + 1;
# }

# print(count);
# print("===== END TES PERFORMA =====");




# # 313 muncul
# fun change(x){
#     print(x);
#     x = 1;
#     print(x);
# }

# var num = 3;
# change(num);
# print(num);


# belummmmmmmmm
# var kata = "tes12";
# for i = 0 .. 5 {
#     print(kata[i]);
# }