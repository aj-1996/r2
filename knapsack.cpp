#include <queue>
#include <iostream>
using namespace std;

struct node
{
	int i;
	float ratio;
	int p,w;
bool operator<(const node &a) const {
        return ratio<a.ratio;
}
 
};


int main()
{
	int n;
	cout<<"Enter the number of objects\n";
	cin>>n;
	int m, p[n],w[n];
	cout<<"enter the values of "<<n<<" objects\n";
	for(int i=0;i<n;i++)
		cin>>p[i];
	cout<<"enter the weights of "<<n<<" objects\n";
	for(int i=0;i<n;i++)
		cin>>w[i];
	cout<<"enter knapsack capacity\n";
	cin>>m;
	priority_queue<node> Q;
	node v;
	for(int i=0;i<n;i++)
	{
		v.i=i;
		v.p=p[i];
		v.w=w[i];
		v.ratio=(float)p[i]/w[i];
		Q.push(v);
	}
	float profit=0;
	float tot_weight=0;
	float x[n];
	int done=0;
	for(int i=0;i<n;i++)
	{
		v=Q.top();
		Q.pop();
				
		if(done)
		{
			x[v.i]=0;
			continue;
		}
		
		if(tot_weight+v.w<=m)
		{
			x[v.i]=1;
			profit=profit+v.p;
			tot_weight+=v.w;
		}
		else
		{
			x[v.i]=(m-tot_weight)/v.w;
			profit=profit+v.p*x[v.i];
			done=1;
		}
	}
	cout<<"profit is "<<profit<<"  total weight is "<<tot_weight<<endl;
	cout<<"solution for knapsack is \n";
	for(int i=0;i<n;i++)
		cout<<x[i]<<" ";
	cout<<endl;
return 1;
}
