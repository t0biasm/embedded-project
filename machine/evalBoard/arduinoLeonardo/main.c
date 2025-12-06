/*
 * Simple LED Blink example for ATmega328p
 * Blinks LED on PB5 (Arduino Pin 13)
 */

#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // Set PB5 as output
    DDRB |= (1 << DDB5);
    
    while (1) {
        // Toggle LED
        PORTB ^= (1 << PORTB5);
        
        // Wait 500ms
        _delay_ms(500);
    }
    
    return 0;
}
