/*
Title: linked-lists.c
Author: John Rieffel
Date: 02/15/2022
Revisions:

To Compile: `gcc -o linked-lists linked-lists.c`

*/

#include <stdio.h>
#include <stdlib.h>


//a custom data type in C
typedef struct node {
    struct node *next;   //a self-referential pointer
    int data;           
    } Node;


//A non-recursive approach to inserting N into a linked list
struct node * insert(int N, struct node *listptr)
{
	//this is how you allocate a new custom struct
	struct node *tmpptr = (struct node *)malloc(sizeof(struct node));
	// set data to N
	tmpptr->data = N;

	// if list is NULL or if N is smaller than first item in list
	if ((listptr == NULL) || (N < listptr->data)) {
		tmpptr->next = listptr; //make list the new next
		listptr = tmpptr;       //make tmp the new list
	}
	else 
	{
		//pointer to current candidate for insertion point
		struct node * curptr = listptr;
		//traverse linked list until we reach the last non-null node 
		//or N > the second node in the list
		while ((curptr->next != NULL) && (curptr->next->data <= N)){
			curptr = curptr->next;
		}
		//curptr points to the node *before*
		//where the new tmp node belongs
		//insert new tmp node into the list after curptr
		tmpptr->next = curptr->next;
		curptr->next = tmpptr;
	}
	return listptr;
}

struct node * insert_recursive(int N, struct node *listptr)
{
	// base case: list is null
	// or N belongs at the beginning
	if ((listptr == NULL) || (listptr->data >= N)){
		//only now do we allocate memory
		struct node *tmpptr = (struct node *)malloc(sizeof(struct node));
   		tmpptr->data = N;
		// the old list becomes the next of the new node
		tmpptr->next = listptr;
		// the new node becomes the new start of the list
		return tmpptr;
	}
	else{
		//otherwise, insert N into the *rest* of the list
		// being sure to set our next node to whatever insert returns
		// our leap of faith is that insert_recursive *will*
		// return a properly sorted linked list
		listptr->next = insert_recursive(N, listptr->next);
		return listptr;
	}


}

void printLinkedList(struct node * inlist)
{
	if (inlist == NULL)
		printf("\n");
	else {
		printf("[%d]->",inlist->data);
		printLinkedList(inlist->next);
	}
	

}

int main()
{
	struct node *lst = (struct node *)NULL;
	int A[10] = {3,1,4,1,5,9,2,6,5,4};
	int i = 0;
	for (i = 0; i < 10; i++)
	{
		lst = insert(A[i],lst);
		printLinkedList(lst);
	}

	struct node *lst2 = (struct node *)NULL;
	for (i = 0; i < 10; i++)
	{
		lst2 = insert_recursive(A[i],lst2);
		printLinkedList(lst2);
	}
}
