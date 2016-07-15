#include <stdio.h>
#include <time.h>
#include <gmp.h>

int main(int argc, char **argv)
{
  int i, trials, mode, bit_size = 0;
  long elapsed = 0L;
  double secs = 0.0;
  mpz_t x,y,z,r;
  mpz_init(x); mpz_init(y); mpz_init(z); mpz_init(r);
  struct timespec ts, te;

  if (argc != 4)
  {
    printf("usage: mod_test mode bit_size trials\n");
    return -1;
  }
  else
  {
    mode = atoi(argv[1]);
    bit_size = atoi(argv[2]);
    trials = atoi(argv[3]);
  }

  mpz_init(r);
  mpz_random(r, bit_size);
  mpz_nextprime(r, r);

  for (i = 0; i < trials; i++) 
  {
    mpz_init(x);
    mpz_init(y);
    mpz_init(z);

    // fill y/z randomly, and then generate the next 160-bit prime
    mpz_random(y, bit_size);
    mpz_random(z, bit_size);
  
    // Time the operation and add up the time
    if (mode == 0)
    {
      clock_gettime(CLOCK_MONOTONIC, &ts);
      mpz_mul(x, y, z);
      mpz_mod(x, x, r);
      clock_gettime(CLOCK_MONOTONIC, &te);
      secs = difftime(te.tv_sec, ts.tv_sec);
      elapsed += ((secs * 1.0e9) + ((double)(te.tv_nsec - ts.tv_nsec)));
    }
    else 
    {
      clock_gettime(CLOCK_MONOTONIC, &ts);
      mpz_add(x, y, z);
      clock_gettime(CLOCK_MONOTONIC, &te);
      secs = difftime(te.tv_sec, ts.tv_sec);
      elapsed += ((secs * 1.0e9) + ((double)(te.tv_nsec - ts.tv_nsec)));
    }
  }

  printf("Trials:       %d\n", trials);
  printf("Total time:   %ld\n", elapsed);
  printf("Average time: %ld\n", elapsed / trials);

  // printf("x = (y * z) mod r = ");
  // mpz_out_str (stdout, 10, x);
  // printf (".\n");

  mpz_clear(x); mpz_clear(y); mpz_clear(z); mpz_clear(r);
  return 0;
}
