// Pandu Putra Pradana
// 23552011062

import 'dart:io';

void main() {
  print("=== Program Logika Sederhana ===");
  stdout.write("Masukkan angka maksimal: ");
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = List.generate(n, (i) => i + 1);

  print("\nDaftar bilangan:");
  print(numbers);

  List<int> primes = numbers.where((num) => isPrime(num)).toList();
  List<int> even = numbers.where((num) => num % 2 == 0).toList();
  List<int> odd = numbers.where((num) => num % 2 != 0).toList();

  print("\nBilangan prima: $primes");
  print("Bilangan genap: $even");
  print("Bilangan ganjil: $odd");

  print("\n=== Statistik ===");
  print("Total angka: ${numbers.length}");
  print("Total prima: ${primes.length}");
  print("Total genap: ${even.length}");
  print("Total ganjil: ${odd.length}");

  int sum = numbers.reduce((a, b) => a + b);
  double avg = sum / numbers.length;
  print("Jumlah total: $sum");
  print("Rata-rata: ${avg.toStringAsFixed(2)}");
}

bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}