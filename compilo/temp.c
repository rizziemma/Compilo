#include <stdio.h>
#include "temp.h"
#include "symbols.h"

int index_temp = MAX_MEM;

int push(){
	index_temp ++;
	return index_temp - 1;
}

int pop(){
	index_temp --;
	return index_temp;
}


