package ks_10_bb;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


//Class to create node for tree
class Node implements Comparable<Node>
{
	float weight;
	float profit;
	float upperBound;
	int level;
	Node left,right;
	
	// Bit map stores the 1/0 bits that tells us which item has been considered in the branch
	ArrayList<Integer> bitMap = new ArrayList<Integer>();  
	
	public Node()
	{
		left=right=null;
	}
	
	// Decides the sorting(Descending) rule on the basis of upper bound
	public int compareTo(Node node) {
		if(this.upperBound<node.upperBound)
			return 1;
		else if(this.upperBound>node.upperBound)
			return -1;
		
		return 0;
	}
}


// Class to store Item weight and profit
class Item implements Comparable<Item>
{
	float weight;
	float profit;
	
	// Decides the sorting(Descending) rule on the basis of density (profit/weight)
	public int compareTo(Item item) {
		if(this.profit/this.weight<item.profit/item.weight)
			return 1;
		else if(this.profit/this.weight>item.profit/item.weight)
			return -1;
		else
			return 0;
	}
	
	// Important for printing list of items in main function
	public String toString() {
		return ""+weight;
	}
}

public class Knapsack 
{
	float capacity;
	int itemCount=0;
	int currentLevel=-1;
	List<Item> itemList = new ArrayList<Item>();
	Node root=null,parent=null,temp;
	List<Node> nodeList = new ArrayList<Node>();
	
	BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
	
	public void getData() 
	{
		try
		{
			System.out.println("Enter capacity:");
			capacity=Integer.parseInt(br.readLine());
			
			System.out.println("Enter total number of items:");
			itemCount=Integer.parseInt(br.readLine());
			for(int i=0;i<itemCount;i++)
			{
				Item it = new Item(); 
				System.out.println("Enter weight:");
				it.weight=Float.parseFloat(br.readLine());
				
				System.out.println("Enter Profit:");
				it.profit=Float.parseFloat(br.readLine());
				
				itemList.add(it);
			}
		}catch (Exception e) {
			System.err.println(e);
		}
		
		Collections.sort(itemList);
	}
	
	public float getUpperBound(Node node)
	{
		float c=0;
		float up=0;
		
		for(int k=0;k<itemCount;k++)
		{
			if(node.bitMap.size()>k)
				if(node.bitMap.get(k)==0)
					continue;
			
			if(c+itemList.get(k).weight<=capacity)
			{
				up=up+itemList.get(k).profit;
				c=c+itemList.get(k).weight;
			}
			else
			{
				up=up+(((capacity-c)*itemList.get(k).profit)/itemList.get(k).weight);
				break;
			}
		}
		
		return up;
	}
	
	public void findMaxUBNodes(Node node)
	{
	   if (node == null)
		       return ;     
		   	
	   if(node.weight<=capacity && (node.left==null && node.right==null))
		   nodeList.add(node);
		   
	   findMaxUBNodes(node.left);
	 
	   findMaxUBNodes(node.right);
	}
	
	public Node getMaxUpNode(Node node)
	{
		nodeList.clear();
		findMaxUBNodes(node);
		Collections.sort(nodeList);
		return nodeList.get(0);
	}
	
	public void BB()
	{
		root=new Node();
		root.profit=0;
		root.weight=0;
		root.level=currentLevel;
		root.upperBound=getUpperBound(root); // finding the Upper bound for root node
		
		
		while(currentLevel<itemCount)
		{
			// This function will give the node that has to be explore further.
			// Parent is always next node having maximum upper bound
			parent=getMaxUpNode(root);
			
			// Getting current level (item index) to be processed
			currentLevel=parent.level+1;
			
			// Here we have stop the loop
			if(currentLevel==itemCount)
				break;
			
			// For left side
			temp = new Node();
			temp.profit=parent.profit+itemList.get(currentLevel).profit;
			temp.weight=parent.weight+itemList.get(currentLevel).weight;
			temp.upperBound=parent.upperBound;
			temp.level = currentLevel;
			
			temp.bitMap.addAll(parent.bitMap);  // copying parent bitmap
			temp.bitMap.add(1);
			
			// Linking left node to parent node
			parent.left=temp;
			
			
			// For right side
			temp = new Node();
			temp.profit=parent.profit;
			temp.weight=parent.weight;
			temp.level = currentLevel;
			temp.bitMap.addAll(parent.bitMap); // copying parent bitmap
			temp.bitMap.add(0);
			
			temp.upperBound=getUpperBound(temp); // finding the Upper bound for node
			
			// Linking right node to parent node
			parent.right=temp;
			
		}
	
	}
	
	public static void main(String[] args) 
	{
		Knapsack knapsack=new Knapsack();
		knapsack.getData();
		knapsack.BB();
		
		// Bit Map of first node in nodeList will contain the answer
		Node n=knapsack.nodeList.get(0);
		System.out.println("Items are selected as per following bit pattern:(1-Considered / 0-Not Considered)");
		System.out.println(knapsack.itemList);
		System.out.println(n.bitMap);
		System.out.println("Total Profit:"+n.profit);
		System.out.println("Total Weight:"+n.weight);
	}	
}