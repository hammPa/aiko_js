# Versi Python yang "Jujur" (Memaksa alokasi Heap setiap operasi)

class Box:
    def __init__(self, val):
        self.val = val

# Pakai Class custom agar Python terpaksa bikin object baru di Heap (malloc)
# setiap kali operasi, persis seperti Aiko "Box".
limit = 100000
count = Box(0)
one = Box(1) 

for i in range(limit):
    # Ini akan memaksa Python bikin object Box baru, lalu dibuang (GC)
    # Persis seperti logika Aiko: create temp, assign, free temp.
    count = Box(count.val + one.val) 

print(count.val)