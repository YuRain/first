#include <iostream>

#include <complex>

#include <fftw3.h>

using namespace std;

int main()

{

    int N=5;

    fftw_complex *in, *out;

    fftw_plan p;

    in=(fftw_complex*)fftw_malloc(sizeof(fftw_complex)*N);

    out=(fftw_complex*)fftw_malloc(sizeof(fftw_complex)*N);

    

    p=fftw_plan_dft_1d(N, in, out, FFTW_FORWARD, FFTW_ESTIMATE);

    fftw_execute(p);

    return 0;

}
