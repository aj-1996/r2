#include<iostream>
using namespace std;

void quick_sort(int array[], int begin, int end);
int partition(int array[], int begin, int end);
int k=0;

int main()
{
	int total;

	cout<<"Enter No of Elements : ";
	cin>>total;

	int array[total];

	cout<<"Enter Elements : ";
	for(int i = 0; i< total; i++)
	{
		cin>>array[i];
	}

	quick_sort(array,0,total-1);

	cout<<"Sorted Elements : ";
	for(int i = 0; i< total; i++)
	{
		cout<<array[i]<<" ";
	}

	cout<<endl;

	return 0;
}


void quick_sort(int array[], int begin, int end)
{
	int middle;

	if(begin<end)
	{
		middle = partition(array,begin,end);
		cout<<"Pivot element with index "<<middle<<" has been found out by thread "<<k<<"\n";

#pragma omp parallel sections
		{
#pragma omp section
			{
				k=k+1;			
				quick_sort(array,begin,middle-1);
			}

#pragma omp section
			{
				k=k+1;			
				quick_sort(array,middle+1,end);
			}
		}

	}//ife

}//quick_sort

int partition(int array[], int begin, int end)
{

	int temp;
	int pivot = array[begin];
	int p = begin+1;
	int q = end;

	while(1)
	{
		while(p < end && pivot >= array[p])
			p++;

		while(pivot < array[q])
			q--;
//7 2 1 4 5 2 9
		if(p < q)
		{
			temp = array[p];
			array[p] = array[q];
			array[q] = temp;
		}
		else
		{
			temp= array[begin];
			array[begin] = array[q];
			array[q]= temp;
			return(q);
		}//else
	}//while

}//partition

