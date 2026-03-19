# --- TEST SUITE: KEGELAPAN AIKO ---

# # 1. Lexer (Diharapkan 2 error)
# var simbol = @;
# var str = "string tanpa tutup;
# var float_aneh = 10.5.5;



# # 2. Parser (Diharapkan 3-4 error)
# var nocolon = 10
# var x = ; 
# if (10 > 5 { 
#     print("kurang tutup kurung");
# }
# for i = 0 10 { 
#     print(i); 
# }
# 10 = x; 
# "string" = y;
# if () {
#     print("kosong");
# }

# # 3. Codegen (Diharapkan banyak error)
# print(variabel_yang_tidak_ada);

# var duplikat = 1;
# var duplikat = 2;

# fun test() {
#     print("oke");
# }
# fun test() { # Error: Fungsi ganda
#     print("ga oke");
# }

# break; # Error: Luar loop
# continue;
# return 10; # Error: Luar fungsi

# var bukan_array = 55;
# bukan_array[0] = 1; # Error: Bukan array

