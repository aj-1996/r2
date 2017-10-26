#include <iostream>
using namespace std;


int binarySearch(int arr[], int lower, int upper, int key)
{
   if (upper >= lower)
   {
        int mid = lower + (upper - lower)/2;

        if (arr[mid] == key) 
        	return mid;

        if (arr[mid] > key) 
        	return binarySearch(arr, lower, mid-1, key);
 	else
        	return binarySearch(arr, mid+1, upper, key);
   }
   return 1;
}
 
int main(void)
{
 int i,key,size;
 cout<<"\n Enter size of Array :";
 cin>>size;

 int arr[size];
 cout<<"\n Enter "<<size<<" Elements (in Ascending order) :";

 for(i=0;i<size;i++)
 {
 cin>>arr[i];
 }  

 cout<<"\n Enter key to be search ???";
 cin>>key;

 int result = binarySearch(arr, 0, size-1, key);
 if(result == 1)
 	cout<<"\n Element is not present in array \n";
 else
 	cout<<"\n Element is present at index " <<result<<"\n\n";
 return 0;
}

