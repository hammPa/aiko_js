print(10);
print(10 + 5);
print(10 - 2);
print(10 * 4);
print(10 / 2);
# print(10 % 3);
print(10 * 4 / 2 + 1);
print("hello world");

var x = 888;
var y = 9987;
print(x);
print(y);

var z = "str";
print(z);


print(false);
var boolean = true;
print(boolean);

# print(10.5);
# var float = 10.5 + 2.3;


var first = 90;
var second = 90;
var isSmall = first < second;

print(first < second);
print(isSmall);

# print(!90);

var sum = x + y;
print(sum);

var nilai = 10;

if(nilai > 10){
    print("muehehehehe");
}
elif(nilai == 9){
    print("elif");
}
elif(nilai == 7){
    print("elif2");
}
elif(nilai == 99){
    print("elif3");
}
else {
    print("else");
    var m = 99;
    print(m);
}


for i = 0 .. 2 {
    print(i);
}


for i = 0 .. 2 {
    for j = 0 .. 2 {
        print(j);
    }
}

for i = 0 .. 2 {
    if(i == 0){
        print("ini 0");
    }
}

for i = 0 .. 2 {
    for j = 0 .. 2 {
        if(j == 1){
            print(j);
            var inner = "hello inner";
            print(inner);
        }
        else {
            print("hemm");
        }
    }
}


fun displayHello(){
    print("hello");
    for i = 0 .. 2 {
        for j = 3 .. 5 {
            if(i == 1){
                print(j);
            }
        }
    }

    var m = 99;
    print(m);
}
displayHello();


# fun callWithParam(param1, param2){
#     print(param1);
#     print(param2);
# }

# fun ret10(){
#     return 10;
# }

# var ten = ret10();