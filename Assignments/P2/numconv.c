/** 
 *  @author  Ryan Blocker
 */

#include <stdio.h>

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
char int_to_char (int value, int radix) {
	int intchar;
	if(value < 10) {
		intchar = value + '0';
		return (char)intchar; 
	}
	else {
		intchar = value + 'A';
		return (char)intchar;
	}   
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
int char_to_int (char digit, int radix) {
        char c = 'A';
	c = c - digit;
	return (int)c;
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
void div_rem (int numerator, int divisor, int* remainder, int* quotient) {
	int remainderresult;
	int quotientresult;
	
	quotientresult = numerator / divisor;
	*quotient = quotientresult;

	remainderresult = numerator % divisor;
	*remainder = remainderresult;
}


/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
int ascii_to_int (int valueOfPrefix, int radix) {
	char c = getchar();
	int asciiInt = radix*valueOfPrefix*(int)c; 
	return asciiInt;
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
void int_to_ascii (int value, int radix) {
	printf("I need help I have no clue what to do here");
}

/** @todo implement in <code>numconv.c</code> based on documentation contained 
 *  in <code>numconv.h</code>.
 */
double frac_to_double (int radix) {
  return -1.0;
}

