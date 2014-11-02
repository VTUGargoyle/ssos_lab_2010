#include <stdio.h>

struct proc {
    int id;
    int arrtime;
    int extime;
    int remtime;
    int fintime;
    int tut;
    int wtime;
} p[10];

int n;

/* Get the process with the SRT when a new process arrives */
int min(int curtime)
{
    int min = 1000;
    int pmin = -1, i = 0;
    do {
	if (p[i].arrtime <= curtime) {
	    if (min > p[i].remtime && p[i].remtime != 0) {
		min = p[i].remtime;
		pmin = i;
	    }
	}
	i++;
    }
    while (i < n);
    return pmin;
}

int main()
{
    int i, curtime = 0, tottut = 0, totwtime = 0, runproc;
    scanf("%d", &n);
    for (i = 0; i < n; i++) {
	p[i].id = i;
	scanf("%d%d", &p[i].arrtime, &p[i].extime);
	p[i].remtime = p[i].extime;
    }

    do {
	runproc = min(curtime);
	if (runproc >= 0) {
	    p[runproc].remtime--;
	    curtime++;
	    if (!p[runproc].remtime) {
		p[runproc].fintime = curtime;
		p[runproc].tut = p[runproc].fintime - p[runproc].arrtime;
		p[runproc].wtime = p[runproc].tut - p[runproc].extime;
	    }
	}
    }
    while (runproc >= 0);
    
    printf("FINTIME\tTAT\tWTIME\n");
    for (i = 0; i < n; i++) {
	printf("%d\t%d\t%d\n", p[i].fintime, p[i].tut, p[i].wtime);
	tottut += p[i].tut;
	totwtime += p[i].wtime;
    }
    printf("%f\t%f\n", tottut / (float)n, totwtime / (float)n);
    return 0;
}
