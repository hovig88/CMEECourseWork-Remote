#include <stdio.h>
#include <stdlib.h>

struct listobj {

    int data;
    struct listobj *next;

};

void traverse_list(struct listobj* lobj)
{
    /* 
    This function traverses a list recursively
    and calls out the integer stored inside
    */

   if (lobj != NULL) {
       printf("int data: %i\n", (*lobj).data);
       traverse_list((*lobj).next);
       printf("int data: %i\n", (*lobj).data); // Postorder execution
   }
}

int main (void)
{

    struct listobj l1;
    struct listobj l2;
    struct listobj l3;
    struct listobj l4;

    //int intarray[3] = {10, 21, 33};

    l1.data = 10;
    l2.data = 21;
    l3.data = 33;
    l4.data = 41;

    l1.next = &l2;
    l2.next = &l3;
    l3.next = NULL;

    // Loop through a linked list:
    struct listobj* p = NULL;
    p = &l1;

    // First, let's look at member selection via a pointer
    int data = 0;
    data = (*p).data;
    // Friendlier:
    data = p->data;

    // Let's leverage to do some looping:
    while (p != NULL){
        printf("data in p: %i\n", (*p).data);
        p = p->next;
    }

    // Let's traverse the list recursively using a function
    printf("Traversing recursively:\n");
    traverse_list(&l1);

    printf("\n");

    // Insert a new element

    l4.next = &l2;
    l1.next = &l4;

    p = &l1;
    while (p != NULL){
    printf("data in p: %i\n", (*p).data);
        p = p->next;
    }

    printf("Traversing recursively:\n");
    traverse_list(&l1);

    printf("\n");
    return 0;
}