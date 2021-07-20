#include <stdio.h>
#include "alphabet.h"
#include "mem.h"
#include "common.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// PrintID
//
void PrintID(ALPHABET *A, int id){
  switch(id){
    case 9:
      fprintf(stderr, "  [+] %3d :'\\t' ( %"PRIu64" )\n", id, A->counts[id]);
    break;
    case 10:
      fprintf(stderr, "  [+] %3d :'\\n' ( %"PRIu64" )\n", id, A->counts[id]);
    break;
    default:
      fprintf(stderr, "  [+] %3d :'%c' ( %"PRIu64" )\n", id, id, A->counts[id]);
    break;
    }
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// CREATE ALPHABET
//
ALPHABET *CreateAlphabet(void){
  ALPHABET *A        = (ALPHABET *) Calloc(1,                 sizeof(ALPHABET));
  A->numeric         = (uint8_t  *) Calloc(ALPHABET_MAX_SIZE, sizeof(uint8_t));
  A->toChars         = (uint8_t  *) Calloc(ALPHABET_MAX_SIZE, sizeof(uint8_t));
  A->revMap          = (uint8_t  *) Calloc(ALPHABET_MAX_SIZE, sizeof(uint8_t));
  A->alphabet        = (uint8_t  *) Calloc(ALPHABET_MAX_SIZE, sizeof(uint8_t));
  A->mask            = (uint8_t  *) Calloc(ALPHABET_MAX_SIZE, sizeof(uint8_t));
  A->counts          = (uint64_t *) Calloc(ALPHABET_MAX_SIZE, sizeof(uint64_t));
  A->length          = 0;
  A->cardinality     = 0;
  return A;
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// RESET ALPHABET
//
void ResetAlphabet(ALPHABET *A){
  uint32_t x;
  A->cardinality = 0;
  for(x = 0 ; x < ALPHABET_MAX_SIZE ; x++){
    if(A->mask[x] == 1){
      A->toChars[A->cardinality] = x;
      A->revMap[x] = A->cardinality++;
      }
    else
      A->revMap[x] = INVALID_SYMBOL;
    }
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// LOAD ALPHABET
//
void LoadAlphabet(ALPHABET *A, char *fname1, char *fname2){
  uint64_t size = 0;
  uint32_t x;
  int32_t  k, header = 0, skip = 0;
  uint8_t  *buffer, *buffer2;
  FILE     *F  = Fopen(fname1, "r");
  FILE     *F2 = Fopen(fname2, "r");

  buffer = (uint8_t *) Calloc(BUFFER_SIZE, sizeof(uint8_t));
  while((k = fread(buffer, 1, BUFFER_SIZE, F)))
    for(x = 0 ; x < k ; ++x){

      switch(buffer[x]){
        case '>':  header = 1; skip = 0; continue;
        case '\n': header = 0; continue;
        default: if(header==1) continue;
        }

      A->mask[buffer[x]] = 1;
      A->counts[buffer[x]]++;
      ++size;
      }

  skip = 0 ;
  header = 0 ;
  buffer2 = (uint8_t *) Calloc(BUFFER_SIZE, sizeof(uint8_t));
  while((k = fread(buffer2, 1, BUFFER_SIZE, F2)))
    for(x = 0 ; x < k ; ++x){

      switch(buffer2[x]){
        case '>':  header = 1; skip = 0; continue;
        case '\n': header = 0; continue;
        default: if(header==1) continue;
        }

      A->mask[buffer2[x]] = 1;
      A->counts[buffer2[x]]++;
      ++size;
      }

  Free(buffer);
  Free(buffer2);

  A->length = size;
  ResetAlphabet(A);
  
  fclose(F);
  fclose(F2);
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// PRINT ALPHABET
//
void PrintAlphabet(ALPHABET *A){
  int x;
  fprintf(stderr, "[>] File size: %"PRIu64"\n", A->length);
  fprintf(stderr, "[>] Alphabet size: %u\n", A->cardinality);
  fprintf(stderr, "[>] Alphabet distribution: \n");
  for(x = 0 ; x < A->cardinality ; ++x){
    PrintID(A, (int) A->toChars[x]);
    }
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// REMOVE ALPHABET
//
void RemoveAlphabet(ALPHABET *A){
  Free(A->numeric);
  Free(A->toChars);
  Free(A->revMap);
  Free(A->alphabet);
  Free(A->mask);
  Free(A->counts);
  Free(A);
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
