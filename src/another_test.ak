var a = 1;
var b = "str";
var c = 10 + 5 * 2;
var d = a + 10;
print(a);
print(b);
print(c);
print(d);
print(100);
print("oi");

var arr = [91, 24, 51, 39];
print("arr: ");
print(arr);

print("arr[1]: ");
print(arr[1]);

print("arr[a]: ");
print(arr[a]);

print("ini print index dari 0 sampai 2 :");
for i = 0 .. 3 {
  print(i);
}

print("ini print index dari 5 sampai 0: ");
for i = 5 .. -1 {
  print(i);
}

print("ini menampilkan semua isi array 2 kali: ");
for i = 0 .. 2 {
  print(arr);
}

print("ini menampilkan 3 buah element dari array perbaris: ");
for i = 0 .. 3 {
  print(arr[i]);
}


for i = 0 .. 2 {
  for j = 0 .. 2 {
    print("hello from nested for");
  }
}

print("1 < 2: ");
print(1 < 2);

print("1 > 2: ");
var one_greater_than_two = 1 > 2;
print(one_greater_than_two);