#include <stdio.h>
#include "temp.h"
#include "symbols.h"


int mem = MAX_MEM;
int index_temp = 0;

int push(){
	index_temp ++;
	return index_temp - 1 + mem;
}

int pop(){
	index_temp --;
	return index_temp + mem;
}


