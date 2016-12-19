/*****************************
* filename: test_fftw.cpp
* author : Tiao Lu
* Company : School of Mathematical Sciences, Peking University
* 编译命令: g++ -o test_fftw.exe test_fftw.cpp -lfftw3
* Date    : September 30th, 2007
* Description: This code is an example to show the use of the free code FFTW, which implements the Fast Fourier Trasformation algorithm.
*/

#include <complex>
#include <fftw3.h>
#include <math.h>
#include <iostream>

#define N 10
using namespace std;
int main(int argc, char * argv[]){

    fftw_complex in[N], out[N];
    fftw_plan p;

//一维dft，in 输入，out输出，FFTW_FORWARD 表示 exp 上指数是负号
// out = F in
//where out and in are two vectors of the same length n, and F is a n-by-n matrix with the (j,k) element
// F jk = exp(-i 2 pi j k /n). i 是虚数单位.

    p=fftw_plan_dft_1d(N,in,out,FFTW_FORWARD,FFTW_MEASURE);
    for(int i=0;i <N;i ++) {
        in[i][0]=i;
        in[i][1]=0.0;
    }
  

    fftw_execute(p);

    for(int i=0;i <N;i ++){
        cout<<out[i][0]<<" "<<out[i][1]<<endl;
    }

    //验证是否 out[3] = \sum_{k=0}^{N-1}exp(-i 2pi 3 k/N)in[k]
    complex<double> temp = 0.0;
    for(int k =0; k < N; k ++){
        double pi = 4*atan(1.0);
        temp += exp(complex<double>(0.0,-2.0*pi*3*k/N))*complex<double>(in[k][0],in[k][1]);
    }
    cout<<"out[3] is "<<temp<<endl;

    fftw_complex out1[N];

    fftw_plan p1;
//一维dft，in 输入，out输出，FFTW_BACKWARD 表示 exp 上指数是正号
// out = IF in
//where out and in are two vectors of the same length n, and IF is a n-by-n matrix with the (j,k) element
// IF jk = exp( +i 2 pi jk/n). i 是虚数单位.

    p1=fftw_plan_dft_1d(N,out1,in,FFTW_BACKWARD,FFTW_MEASURE);

    for(int i=0;i <N;i ++){
        out1[i][0]=out[i][0];
        out1[i][1]=out[i][1];
    }

    fftw_execute(p1);
//注意这里得到的 in 并不是和原来的in 的数值不同，比较之后发现，现在的in
// 是原来的 in 的 N 倍。原因是这里的定义的逆傅立叶变换没有除以 N.
//这和课本中定义的逆傅立叶变换不同。
    for(int i=0;i <N;i ++){
        cout<<in[i][0]<<" "<<in[i][1]<<endl;
    }



    fftw_destroy_plan(p);
    fftw_destroy_plan(p1);
    return 1;
}
