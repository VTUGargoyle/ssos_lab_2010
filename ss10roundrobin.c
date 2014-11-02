#include <stdio.h>

/*
$ gcc roundrobin.c -o rr
$ ./rr < rrinput
*/

struct proc {
    int id;			       // the process id
    int arrtime;		       // arrival time 
    int extime;			       // estimated execution time
    int remtime;		       // remaining time for completion
    int fin;			       // finished the execution ?
    int fintime;		       // the process completion time
    int tat;			       // turn around time for the process
    int wtime;			       // the waiting time
    int inserted;		       // already inserted to the queue ?
} p[10];

int q[10], front = 0, rear = 0, n;

/* Queue operations for insertion and removal of the processes */
void insert(int ele)
{
    q[rear] = ele;
    rear = (rear + 1) % n;
}

int rem()
{
    int ele;
    ele = q[front];
    front = (front + 1) % n;
    return ele;
}

int main()
{
    int i, curtime = 0, fin = 0, quantum, tottat = 0, totwtime = 0, runproc;
    scanf("%d", &n);
    for (i = 0; i < n; i++) {
	p[i].id = i;
	scanf("%d%d", &p[i].arrtime, &p[i].extime);
	p[i].remtime = p[i].extime;
	p[i].fin = 0;
	p[i].inserted = 0;
    }
    scanf("%d", &quantum);
    curtime = p[0].arrtime;
    insert(0);			       // Start by inserting the first process to the queue
    p[0].inserted = 1;
    for (i = 0; fin < n;) {
	runproc = rem();	       // Get the first process in the queue
	curtime += (p[runproc].remtime > quantum) ? quantum : p[runproc].remtime;	// current time is incremented 
	p[runproc].remtime = (p[runproc].remtime > quantum) ? p[runproc].remtime - quantum : 0;
	if (p[runproc].remtime == 0 && !p[runproc].fin) {
	    fin++;
	    p[runproc].fin = 1;
	    p[runproc].fintime = curtime;
	    p[runproc].tat = p[runproc].fintime - p[runproc].arrtime;
	    p[runproc].wtime = p[runproc].tat - p[runproc].extime;
	}
	i = 0;
	while (i < n) {
	    if (!p[i].inserted && p[i].arrtime <= curtime) {
		insert(i);
		p[i].inserted = 1;
	    }
	    i++;
	}
	insert(runproc);
    }
    
    printf("FINTIME\tTAT\tWTIME\n");
    for (i = 0; i < n; i++) {
	printf("%d\t%d\t%d\n", p[i].fintime, p[i].tat, p[i].wtime);
	tottat += p[i].tat;
	totwtime += p[i].wtime;
    }
    printf("%f\t%f\n", tottat / (float)n, totwtime / (float)n);
    return 0;
}
