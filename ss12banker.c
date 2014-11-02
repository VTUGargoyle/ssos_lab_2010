#include <stdio.h>

#define P 5
#define R 5

int order[P];
int fin[P];
void putmx(int a[][R], int p, int r)
{
    int i, j;
    for (i = 0; i < p; i++) {
        for (j = 0; j < r; j++) {
            printf("%d ", a[i][j]);
        }
        puts("");
    }
}

void putvec(int b[], int p)
{
    int i;
    for (i = 0; i < p; i++)
        printf("%d ", b[i]);
    puts("");
}

void getmx(int a[][R], int p, int r)
{
    int i,j;
    for (i = 0; i < p; i++) 
        for (j = 0; j < r; j++) 
            scanf("%d ", &a[i][j]);
}

int safeseq(int a[][R], int need[][R], int avail[], int p, int r)
{
    int ordcnt = 0, i, j, k, l, flag;
    for (i = 0; i < p; i++) {
        for (j = 0; j < p; j++) {
            if (fin[j])
                continue;
            flag = 1;
            for (k = 0; k < r; k++) {
                if (need[j][k] > avail[k]) {
                    flag = 0;
                    break;
                }
            }
            if (flag) {
                order[ordcnt++] = j;
                fin[j] = 1;
                for (l = 0; l < r; l++) 
                    avail[l] += a[j][l];
                if (ordcnt == p)
                    return 1;
            }
        }
    }
    return 0;
}

int main()
{
    int claim[P][R];
    int alloc[P][R];
    int avail[R], availbac[R];
    int need[P][R];
    int i, j, p, r, opt, res, id;
    printf("enter the number of processes and resources\n");
    scanf("%d%d", &p, &r);
    puts("enter the claim matrix");
    getmx(claim, p, r);
    puts("enter the allocated resource table");
    getmx(alloc, p, r);
    puts("enter the available vector");
    for (j = 0; j < r; j++) {
        scanf("%d", &avail[j]);
        availbac[j] = avail[j];
    }
    for (i = 0; i < p; i++) {
        for (j = 0; j < r; j++) {
            need[i][j] = claim[i][j] - alloc[i][j];
            if (need[i][j] < 0) {
                printf("alloc > claim\n");
                return 1;
            }
        }
    }
    puts("allocation table:");
    putmx(alloc, p, r);
    puts("need table");
    putmx(need, p, r);
    puts("available vector:");
    putvec(avail, r);
    if (safeseq(alloc, need, avail, p, r)) {
        puts("processes are in a safe state, possible safe sequence:");
        putvec(order, p);
        printf("additional request?\n");
        scanf("%d", &opt);           // opt == 0 means not checking for additional request
        if (opt) {
            for (i = 0; i < p; i++)
                fin[i] = 0;
            for (j = 0; j < r; j++)
                avail[j] = availbac[j];
            printf("enter process id requiring more resources\n");
            scanf("%d", &id);
            printf("enter resource request\n");
            for (j = 0; j < r; j++) {
                scanf("%d", &res);
                alloc[id][j] += res;
                avail[j] -= res;
                need[id][j] = claim[id][j] - alloc[id][j];
                if (need[id][j] < 0) {
                    printf("can't grant the resources\n");
                    return 1;
                }
            }
            puts("new allocation table:");
            putmx(alloc, p, r);
            puts("new need table:");
            putmx(need, p, r);
            puts("new available vector:");
            putvec(avail, r);
            if (safeseq(alloc, need, avail, p, r)) {
                printf("safe sequence exists, can grant resources\n");
                putvec(order, p);
                return 0;
            } else {
                printf("can't grant the resources\n");
                return 1;
            }
        }
    } else
        printf("not in safe state\n");
    puts("");
    return 0;
}
