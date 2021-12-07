#include<stdio.h>
#include<stdlib.h>

struct node
{
    int data;
    struct node *left,*right;
};

/* Function to count number of nodes in a Binary Tree */
int count=0;
struct node * createnode(struct node *newnode,int data)
{
    newnode=malloc(sizeof(struct node));
    newnode->data=data;
    newnode->left= newnode->right = NULL;
    return newnode;
}
void insert(struct node **root,int data)
{
    struct node *newnode;
    newnode=createnode(newnode,data);
    if(*root==NULL)
    *root=newnode;
    else
    {
        struct node *temp=*root;
        while(1)
        {
            if(data <= temp->data)
            {
                if(temp->left==NULL)
                {temp->left=newnode;
                break;}
                temp=temp->left;
            }
            else
            {  
            if(temp->right==NULL)
            {temp->right=newnode;
            break;}
            temp=temp->right;
            }
        }
    }
}

void createbst(struct node **root)
{
    int n,i;
    int data;
    printf("Enter the number of nodes: ");
    scanf("%d",&n);
    for(i=0;i<n;i++)
    {
        printf("Enter data: ");
        scanf("%d",&data);
        insert(root,data);
    }
}    

int search(struct node *root, int data)
{if(root==NULL)
printf("Empty Tree");
    else
    {
        struct node *temp=root;
        while(1)
        {
        if(data <= temp->data)
            {
            if(temp->left==NULL)
            return 0;
            temp=temp->left;
            if(temp->data == data)
            return 1;
            }
        else
            { 
            if(temp->right==NULL)
            return 0;
            temp=temp->right;
            if(temp->data == data)
            return 1;
            }
        }
    }
}

void display(struct node *temp)
{
if(temp)
{
printf("%d",temp->data);
display(temp->left);
display(temp->right);
}
}
void countNodes(struct node *temp)
{
if(temp)
{
count++;
countNodes(temp->left);
countNodes(temp->right);
}
}
int menu()
{
int ch;
printf("\n0.Exit");
printf("\n1.Create tree");
printf("\n2.Display tree");
printf("\n3.Search a node");
printf("\n4.Count nodes in the tree");

printf("\nEnter your choice: ");
scanf("%d",&ch);
return ch;
}

main()
{
struct node *root= NULL;
int ch;
while((ch=menu())!=0)
{
if(ch==1)
createbst(&root);
else
if(ch==2)
{
display(root);
printf("\n");
getchar();
}
else
if(ch==3)
{
int data;
printf("\nEnter data to be searched: ");
scanf("%d",&data);

if(search(root,data) == 1 )
printf("Node %d is present in tree\n",data);
else
printf("Node %d is not present in tree\n",data);
getchar();
}
else
if(ch==4)
{
countNodes(root);
printf("Nodes are : %d\n",count);
getchar();
}
}
}
