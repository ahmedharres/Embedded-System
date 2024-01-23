/*
 * LCD_KEYPAD.c
 *
 * Created: 21/12/2023 18:00:40
 * Author: ahmedharres
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <mega16.h>
#include <alcd.h>
#include <delay.h>

char Keypad();
void main(void)
{
	int lcd_position = 0;  // Track the LCD position
	char number;
	DDRC = 0b00000111;
	PORTC = 0b11111000;
	lcd_init(16);
	while (1)
		{
        lcd_puts("Start Enter Number !!");
        
		// Please write your application code here
		number = Keypad();

		// Display the pressed number on the LCD
	    lcd_gotoxy(lcd_position % 16, lcd_position / 16);  // Set LCD position
		lcd_printf("%d", number);

		// Increment the LCD position
		lcd_position++;

		// If the LCD is full, clear it and start over
		if (lcd_position >= 16 * 2)
			{
			lcd_clear();
			lcd_position = 0;
			}

		// Delay to prevent multiple inputs in a short time
		delay_ms(500);
		}
}


// Implement Keypad() function
// Implement Keypad() function
char Keypad()
{
	while (1)
		{
		PORTC.0 = 0; // col 1 is active
		PORTC.1 = 1; // col 2 is inactive
		PORTC.2 = 1; // col 3 is inactive
		switch (PINC)
			{
			case 0b11110110:
				while (PINC.3 == 0);
				return 1;
				break;

			case 0b11101110:
				while (PINC.4 == 0);
				return 4;
				break;

			case 0b11011110:
				while (PINC.5 == 0);
				return 7;
				break;

			case 0b10111110:
				while (PINC.6 == 0);
				return 10; // '*' is returned as 10
				break;
			}

		PORTC.0 = 1; // col 1 is inactive
		PORTC.1 = 0; // col 2 is active
		PORTC.2 = 1; // col 3 is inactive
		switch (PINC)
			{
			case 0b11110101:
				while (PINC.3 == 0);
				return 2;
				break;

			case 0b11101101:
				while (PINC.4 == 0);
				return 5;
				break;

			case 0b11011101:
				while (PINC.5 == 0);
				return 8;
				break;

			case 0b10111101:
				while (PINC.6 == 0);
				return 0;
				break;
			}

		PORTC.0 = 1; // col 1 is inactive
		PORTC.1 = 1; // col 2 is inactive
		PORTC.2 = 0; // col 3 is active
		switch (PINC)
			{
			case 0b11110011:
				while (PINC.3 == 0);
				return 3;
				break;

			case 0b11101011:
				while (PINC.4 == 0);
				return 6;
				break;

			case 0b11011011:
				while (PINC.5 == 0);
				return 9;
				break;

			case 0b110111011:
				while (PINC.6 == 0);
				return 11; // '#' is returned as 11
				break;
			}
		}
}
