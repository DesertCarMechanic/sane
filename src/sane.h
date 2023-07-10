
#include <stdint.h>

// macros are normally defined in uppercase. why should "true" and "false" 
// be different?
#define FALSE 0
#define TRUE 1

#define NULL ((void *)0)

// much easier to type
#define i8 int8_t
#define i16 int16_t
#define i32 int32_t
#define i64 int64_t
#define u8 uint8_t
#define u16 uint16_t
#define u32 uint32_t
#define u64 uint64_t

// what people should be using as default instead of "int"
#define uint unsigned int

// makes working with bytes much more self-explanatory
#define byte char

