// C solution to day 6 part 2

#include <stdio.h>

unsigned long long fish[9] = {
  0, 84, 59, 54, 48, 55, 0, 0, 0
};

int main() {
  unsigned long long f0;
  for (int i = 0; i < 256; i++) {
    f0 = fish[0];
    for (int j = 1; j <= 8; j++) {
      fish[j - 1] = fish[j];
    }
    fish[6] += f0;
    fish[8] = f0;
  }
  unsigned long long sum = 0;
  for (int j = 0; j <= 8; j++) {
    sum += fish[j];
  }
  printf("%llu\n", sum);
}
