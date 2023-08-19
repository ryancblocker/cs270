#include "Debug.h"
#include "iFloat.h"
#include <stdlib.h>

/** @file iFloat.c
 *  @brief You will modify this file and implement nine functions
 *  @details Your implementation of the functions defined in iFloat.h.
 *  You may add other function if you find it helpful. Added function
 *  should be declared <b>static</b> to indicate they are only used
 *  within this file.
 *  <p>
 *  @author <b>Your name</b> goes here
 */

/* declaration for useful function contained in testFloat.c */
const char* getBinary (iFloat_t value);

/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatGetSign (iFloat_t x) {
	x = (x & 0b1000000000000000) >> 15;
	if (x == 0)
		return 0;
	else{
		return 1;
	} /* implement this */
}

/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatGetExp (iFloat_t x) {
  int net = 0b0111111110000000;
  int new_x = net & x;
  new_x = new_x >> 7;

  return new_x;
}

/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatGetVal (iFloat_t x) {
  int fsign = floatGetSign(x); //0 if positive, 1 if negative
  int net = 0b0000000011111111;
  int ret = x & net;
  if(fsign != 0){
    ret = ~ret + 1;
    return ret;
  }
  return ret + 0b0000000010000000;
}


/** @todo Implement based on documentation contained in iFloat.h */
void floatGetAll(iFloat_t x, iFloat_t* sign, iFloat_t*exp, iFloat_t* val) {
  *sign = floatGetSign(x);
  *exp = floatGetExp(x);
  *val = floatGetVal(x);
}

/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatLeftMost1 (iFloat_t bits) {
  if(bits == 0){
  return -1;
  }
for (int i = 15; i >= 0; i--) { 
        int temp = (bits & (0b0000000000000001 << i));
        if (temp != 0){
          return i;
        }
    } 
return -1;
}


/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatAbs (iFloat_t x) {
  if (x == 0.0){
    return 0.0;
  }
  return (x & 0b0111111111111111);
}
/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatNegate (iFloat_t x) {
  if(x < 0 || x > 0){
    return x ^ 0b1000000000000000;
  }
  else{
    return x;
  }
}

/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatAdd (iFloat_t x, iFloat_t y) {
    
 if(x==0){
     return y;
 }
 if(y==0){
     return x;
 }
 if(x==floatNegate(y)){
     return 0;
 }
 
 int tmpx=floatGetVal(x);
 int tmpy=floatGetVal(y);
 int expy=floatGetExp(y);
 int expx=floatGetExp(x);
 int expz=expx;
 
 if(expx != expy){
     int diff = abs(expx-expy);
        if(expx > expy){
            tmpy=tmpy>>diff;
        }
        else{
            expz=expy;
            tmpx=tmpx>>diff;
        }
 }
 
 int z = tmpx+tmpy;
 int sign = 0;
 
 if(floatGetSign(z)==1){
     z=(~z)+1;
     sign = 1;
 }
 
 int left = floatLeftMost1(z);
 if(left!=-1){
     if(left>BITS_MANT){
         z=z>>(left-BITS_MANT);
         expz+=left-BITS_MANT;
     }
     else if(left<BITS_MANT){
         z=z<<(BITS_MANT-left);
         expz-=BITS_MANT-left;
     }
 }
 
 int sum = sign;
 
 sum=sum<<BITS_EXP;
 sum+=expz;
 sum=sum<<BITS_MANT;
 sum+=(z&~(-1<<BITS_MANT));

 return sum;
}

/** @todo Implement based on documentation contained in iFloat.h */
iFloat_t floatSub (iFloat_t x, iFloat_t y) {
  return floatAdd(x, floatNegate(y));
}



