#ifndef COMMON_H_INCLUDED
#define COMMON_H_INCLUDED

#include "context.h"
#include "defs.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

FILE        *Fopen           (const char *, const char *);
void        FillLogTable     (uint32_t, uint32_t, uint32_t);
double      SearchLog        (uint32_t );
double      Power            (double, double);
uint32_t    FLog2            (uint64_t );
uint8_t     S2N              (uint8_t  );
uint8_t     N2S              (uint8_t  );
uint8_t     GetCompNum       (uint8_t  );
uint8_t     GetCompSym       (uint8_t  );
uint64_t    NDNASyminFile    (FILE *);
uint64_t    NBytesInFile     (FILE *);
uint64_t    FopenBytesInFile (const char *);
uint8_t     *ReverseStr      (uint8_t *, uint32_t);
char        *CloneString     (char *   );
char        *RepString       (const char *, const char *, const char *);
uint32_t    ArgsNum          (uint32_t, char *[], uint32_t, char *, char *,
		              uint32_t, uint32_t);
double      ArgsDouble       (double, char *[], uint32_t, char *, char *);
uint8_t     ArgsState        (uint8_t  , char *[], uint32_t, char *, char *);
char        *ArgsString      (char    *, char *[], uint32_t, char *, char *);
char        *ArgsFiles       (char *[], uint32_t, char *);
void        TestReadFile     (char *);
void        FAccessWPerm     (char    *);
uint32_t    ReadFNames       (Param *, char *);
void        CalcProgress     (uint64_t , uint64_t);
void        CalcProgressTar  (uint64_t , uint64_t, uint64_t, uint64_t);
void        PrintArgs        (Param *);
char        *concatenate     (char *   , char *);

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#endif
