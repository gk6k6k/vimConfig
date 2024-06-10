#include "example.cuh"
#include <algorithm>
#include <iostream>

int main(int argc, char *argv[]) {
  int N = 1 << 20;
  float *x, *y;
  x = (float *)malloc(N * sizeof(float));
  y = (float *)malloc(N * sizeof(float));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  wrap(x, y, N);

  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = std::max(maxError, std::abs(y[i] - 4.0f));
  printf("Max error: %f\n", maxError);

  free(x);
  free(y);

  return 0;
}
