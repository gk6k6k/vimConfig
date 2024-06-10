__global__
void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
}

void wrap(float *x, float *y, int N) {

    float *d_x, *d_y;

  cudaMalloc(&d_x, N*sizeof(float)); 
  cudaMalloc(&d_y, N*sizeof(float));


  cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);

  saxpy<<<(N+255)/256, 256>>>(N, 2.0f, d_x, d_y);


  cudaMemcpy(y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost);

}
