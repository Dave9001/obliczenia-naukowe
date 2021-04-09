#include <stdio.h>
#include <float.h>

int main ( void )
{
	printf("FLT 1E-5  : %e\n",FLT_EPSILON);
	printf("DBL 1E-9  : %e\n",DBL_EPSILON);
	printf("LDBL 1E-9 : %Le\n",LDBL_EPSILON);

	return 0;
}
