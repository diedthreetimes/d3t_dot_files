#include <stdio.h>
#include <string.h>
#include <time.h>
#include <openssl/sha.h>

#define BUF_SIZE 20

int main(int argc, char** argv)
{
    unsigned char obuf[BUF_SIZE]; // 160 bits
    unsigned char ibuf[BUF_SIZE]; // 160 bits
    struct timespec ts, te;
    int trials, i, j = 0;
    long elapsed = 0L;
    double secs = 0.0;

    if (argc != 2)
    {
        printf("Specify the number of trials...\n");
        return -1;
    }
    else
    {
        trials = atoi(argv[1]);
    }

    
    //clock_gettime(CLOCK_MONOTONIC, &ts);
    for (i = 0; i < trials; i++)
    {
        // generate random bytes (far from truly random... but that's OK for the test)
        for (j = 0; j < BUF_SIZE; j++) ibuf[j] = (rand() % 256);
        
        // time the hash computation
        clock_gettime(CLOCK_MONOTONIC, &ts);
        SHA1(ibuf, BUF_SIZE, obuf);
        clock_gettime(CLOCK_MONOTONIC, &te);
        secs = difftime(te.tv_sec, ts.tv_sec);
        elapsed += ((secs * 1.0e9) + ((double)(te.tv_nsec - ts.tv_nsec)));
    }

     /* clock_gettime(CLOCK_MONOTONIC, &te); */
     /* secs = difftime(te.tv_sec, ts.tv_sec); */
     /* elapsed += ((secs * 1.0e9) + ((double)(te.tv_nsec - ts.tv_nsec))); */


    printf("Trials:       %d\n", trials);
    printf("Total time:   %ld\n", elapsed);
    printf("Average time: %ld\n", elapsed / trials);

    return 0;
}
