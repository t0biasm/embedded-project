#ifndef IO_H
#define IO_H

#include <cstdint>

#ifdef __cplusplus
extern "C" {
#endif

#define DDRC mock_ddrc
extern uint8_t mock_ddrc;

#define DDC6 mock_ddc6
extern uint8_t mock_ddc6;

#define DDC7 mock_ddc7
extern uint8_t mock_ddc7;

#ifdef __cplusplus
}
#endif

#endif