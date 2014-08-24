#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define MAX(x, y) (x>y? x:y)
#define MIN(x, y) (x<y? x:y)

typedef struct
{
	double x1, x2;
}vector;

vector X[1005];
double alpha[1005];
double b;
int y[1005];
int m;

const double sigma = 0.1;	//0.1
const double C = 1.0;		//1.0

int getData(){
	int i = 0;
	freopen("data.txt", "r", stdin);
	while(scanf("%lf %lf %d", &X[i].x1, &X[i].x2, &y[i]) != EOF){
		if(y[i] == 0) y[i] = -1;
		i++;
	}
	return i;
}

double kernel(vector v1, vector v2){
	double res = (v1.x1 - v2.x1)*(v1.x1 - v2.x1) + (v1.x2 - v2.x2)*(v1.x2 - v2.x2);
	return exp(-res/(2*sigma*sigma));
}

double predict(vector v){
	double res = 0;
	for(int i=0; i<m; i++){
		res += y[i]*alpha[i]*kernel(X[i], v); 
	}
	return res + b;
}

void smo(int MaxIters){
	double Ei, Ej, L, H, newAlphai, newAlphaj;

	while(MaxIters--){
		for(int j=0; j<m; j++){
			double uj = predict(X[j]);
			// 找出不满足KKT条件的alpha
			if(alpha[j] == 0 && y[j]*uj > 1) continue;
			if(alpha[j] == C && y[j]*uj < 1) continue;
			if(alpha[j] > 0 && alpha[j] < C && y[j]*uj == 1) continue;

			Ej = uj - y[j];
			double maxnum = -1;
			int idx = -1;
			int i = 0;
			for(; i<m; i++){
				if(i == j) continue;
				double ui = predict(X[i]);
				Ei = ui - y[i];
				// // 满足KKT条件的alpha
				// if((alpha[i] == 0 && y[i]*ui > 1) ||
				// 	(alpha[i] == C && y[i]*ui < 1) ||
				// 	(alpha[i] > 0 && alpha[i] < C && y[i]*ui == 1)){
					
				// }
				if(abs(Ei - Ej) > maxnum){
					maxnum = abs(Ei - Ej);
					idx = i;
				}
			}
			if(idx == -1) continue;
			i = idx;
			//printf("%d %f\n", i, X[i].x1);
			Ei = predict(X[i]) - y[i];
			// 计算alphaj的上下界L和H
			if(y[i] != y[j]){
				L = MAX(0, alpha[j] - alpha[i]);
				H = MIN(C, alpha[j] - alpha[i] + C);
			}
			else{
				L = MAX(0, alpha[j] + alpha[i] - C);
				H = MIN(C, alpha[j] + alpha[i]);
			}
			if(L >= H) continue;

			double K = kernel(X[i], X[i]) + kernel(X[j], X[j]) - 2*kernel(X[i], X[j]);
			newAlphaj = alpha[j] + y[j]*(Ei - Ej) / K;
			if(newAlphaj < L)
				newAlphaj = L;
			else if(newAlphaj > H)
				newAlphaj = H;

			newAlphai = alpha[i] + y[i]*y[j]*(alpha[j] - newAlphaj);
			//更新b
			double b1 = b - Ei - y[i]*(newAlphai - alpha[i])*kernel(X[i], X[i]) - y[j]*(newAlphaj - alpha[j])*kernel(X[j], X[j]);
			double b2 = b - Ej - y[i]*(newAlphai - alpha[i])*kernel(X[i], X[i]) - y[j]*(newAlphaj - alpha[j])*kernel(X[j], X[j]);
			if(newAlphai > 0 && newAlphai < C)
				b = b1;
			else if(newAlphaj > 0 && newAlphaj < C)
				b = b2;
			else
				b = (b1 + b2)/2;

			alpha[i] = newAlphai;
			alpha[j] = newAlphaj;

			printf("%d %d\n", i, j);
		}
	}
}

int main(){
	m = getData();

	memset(alpha, 0, sizeof(alpha));
	b = 0;

	smo(2);

	printf("b: %f\n", b);
	freopen("result.txt", "w+", stdout);
	for(int i=0; i<m; i++){
		if(predict(X[i]) >= 0)
			printf("%lf %lf 1\n", X[i].x1, X[i].x2);
		else
			printf("%lf %lf 0\n", X[i].x1, X[i].x2);
	}
	return 0;
}