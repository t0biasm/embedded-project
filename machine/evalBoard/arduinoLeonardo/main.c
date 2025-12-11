/*
 * Simple LED Blink example for ATmega328p
 * Blinks LED on PB5 (Arduino Pin 13)
 */

#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // Set PC7 (pin 13 on Leonardo) as output
    DDRC |= (1 << DDC7);
    
    while (1) {
        // Toggle LED
        PORTC ^= (1 << PORTC7);
        
        // Wait 500ms
        _delay_ms(1000);
    }
    
    return 0;
}
