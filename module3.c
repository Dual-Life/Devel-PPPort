#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

void call_newCONSTSUB_3(void)
{
  newCONSTSUB(gv_stashpv("Devel::PPPort", FALSE), "test_value_3", newSViv(3));
}
