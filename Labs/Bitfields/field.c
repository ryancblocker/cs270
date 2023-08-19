#include "field.h"

/** @file field.c
 *  @brief You will modify this file and implement five functions
 *  @details Your implementation of the functions defined in field.h.
 *  You may add other function if you find it helpful. 
 * <p>
 * @author Ryan Blocker
 */

/** @todo Implement in field.c based on documentation contained in field.h */
int getBit (int value, int position) {
        int mask = 1;
	mask = mask << position;
	int curr = value & mask;
	if(curr == mask) {
		return 1;
	}
return 0;
}

/** @todo Implement in field.c based on documentation contained in field.h */
int setBit (int value, int position) {
	int mask = 1;
	mask = mask << position;
	return mask | value;

}

/** @todo Implement in field.c based on documentation contained in field.h */
int clearBit (int value, int position) {
	int mask = 1;
	mask = mask << position;
	mask = ~mask;
	int curr = mask & value;
        return curr;
}

/** @todo Implement in field.c based on documentation contained in field.h */
int getField (int value, int hi, int lo, bool isSigned) {
	int mask = 1;	
	int diff = (hi - lo) + 1; 
	mask = mask << diff;
	mask = mask - 1;
	mask = mask << diff;
	int curr = value & mask;
	if (curr == value) {
		return 1;
	}
return 0;
}	
