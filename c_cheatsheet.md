# Add Macro definition during compile
	gcc -DTEST
	add #define TEST during compiling

	
# get compilation date and time	
#include <stdio.h>

int main()
{
    printf("date: '%s'\n", __DATE__);
    printf("time: '%s'\n", __TIME__);
    printf("timestamp: '%s'\n", __TIMESTAMP__);
}