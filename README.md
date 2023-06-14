# 16-bit-Decimal-Calculator-CSE331

The project combines Proteus simulation and hardware implementation to create a functional system. In the simulation phase, Proteus software is used to model an 8086 microprocessor and an 8255A microcontroller. Assembly Language is utilized to program the microprocessor and interface with a 4x4 keyboard for input and an LCD display for output. The hardware implementation involves using an Arduino Uno microcontroller board and C++ programming. A physical 4x4 matrix calculator and an I2C LCD display are integrated with the Arduino Uno to capture user input and display results. The project demonstrates the versatility of embedded systems, showcasing the simulation capabilities of Proteus and the real-world interaction provided by the Arduino Uno and its programming language.

# Software Simulation:
In our simulation, we utilized Proteus software to model the behavior of our microprocessor-based system. We designed and simulated a system using an 8086 microprocessor and an 8255A microcontroller. The 8086 microprocessor, a widely-used 16-bit processor, provided a powerful instruction set and the capability to address up to 1MB of memory. The 8255A microcontroller, on the other hand, served as a programmable peripheral interface (PPI) chip, offering general-purpose parallel I/O functionality.

To facilitate user input, we incorporated a 4x4 keyboard into our simulation. The 4x4 keyboard consisted of 16 buttons arranged in a matrix format. Each button represented a unique key that could be pressed by the user. The keyboard matrix employed a scanning mechanism to detect simultaneous key presses and relay the information to the microcontroller.

For displaying output, we employed an LCD (Liquid Crystal Display) module. LCD displays are commonly used in embedded systems due to their low power consumption, compact size, and ease of integration. Our specific LCD module supported the display of alphanumeric characters and provided a simple interface for visual feedback.

In our simulation setup, we connected the 8086 microprocessor, the 8255A microcontroller, the 4x4 keyboard, and the LCD module using appropriate interfaces and communication protocols. The 8086 microprocessor acted as the system controller, overseeing the overall operation, while the 8255A microcontroller handled parallel I/O tasks and facilitated communication between the keyboard and LCD.

We connected the keyboard to the input ports of the 8255A microcontroller, enabling it to receive signals from the pressed keys. The microcontroller processed the input and communicated the results to the 8086 microprocessor. The 8086 microprocessor further processed the input data and generated the appropriate output.

To display the output, we utilized the 8255A microcontroller as an intermediary between the 8086 microprocessor and the LCD module. The microcontroller facilitated signal conversions and communication protocols required to control the LCD module and display the desired information.

Proteus software played a crucial role in our simulation. It provided us with a comprehensive environment to design, simulate, and debug electronic circuits and systems. With Proteus, we were able to create an intricate simulation of our system, incorporating the 8086 microprocessor, 8255A microcontroller, 4x4 keyboard, and LCD display.

Through our simulation in Proteus, we effectively validated the functionality of our design and identified any potential issues or optimizations before proceeding to the physical implementation of the circuitry.

![cse331-simulation](https://github.com/FarhanTahmid/16-bit-Decimal-Calculator-CSE331/assets/62169118/7903a3b8-d27f-4a15-a107-d367c6fb07f0)

In conclusion, our simulation setup using Proteus, the 8086 microprocessor, 8255A microcontroller, 4x4 keyboard, and LCD display exemplifies a typical configuration for an embedded system. It showcases the integration of various components to create a functional system capable of user interaction and visual feedback.

# Codes:
In our simulation, we employed Assembly Language to program and control the behavior of the entire system. Assembly Language is a low-level programming language that directly corresponds to the machine code instructions executed by the microprocessor. It offers precise control over the hardware and enables us to optimize performance and resource utilization.

To implement our design, we wrote Assembly Language code that targeted the 8086 microprocessor, the core component of our simulation. The 8086 microprocessor is a 16-bit processor known for its powerful instruction set and ability to address up to 1MB of memory. By writing Assembly Language code specifically for the 8086 microprocessor, we were able to leverage its capabilities to efficiently execute our desired operations.

Our Assembly Language code encompassed various aspects of the system's functionality. We wrote code to handle keyboard input, utilizing the 8255A microcontroller as an interface to receive signals from the 4x4 keyboard. Through appropriate Assembly Language instructions, we processed the keyboard input and captured the pressed keys for further processing.

![cse331-keypad1](https://github.com/FarhanTahmid/16-bit-Decimal-Calculator-CSE331/assets/62169118/e0c0b8a0-735d-46a5-b8bc-bcdb72249a8d)

Additionally, we utilized Assembly Language code to generate output for the LCD display. By communicating with the 8255A microcontroller, we sent the necessary data and instructions to control the LCD module, ensuring the desired information was displayed accurately.

![cse331-lcd](https://github.com/FarhanTahmid/16-bit-Decimal-Calculator-CSE331/assets/62169118/6ab7064b-2a52-44b4-841f-47f3bccc9296)

Throughout our Assembly Language code, we leveraged the specific instructions and features of the 8086 microprocessor to maximize efficiency and performance. We utilized the processor's rich instruction set, including arithmetic, logic, control flow, and I/O instructions, to implement the desired functionality of our system.

By incorporating our Assembly Language code into the 8086 microprocessor in the simulation, we were able to fully leverage the capabilities of the microprocessor and precisely control the behavior of the system. This allowed us to emulate the intended functionality of the physical hardware setup accurately.

![cse331-keypad2](https://github.com/FarhanTahmid/16-bit-Decimal-Calculator-CSE331/assets/62169118/e6ecd944-8b2a-4f20-8ea7-3b6fa54c60a8) ![cse331-keypad3](https://github.com/FarhanTahmid/16-bit-Decimal-Calculator-CSE331/assets/62169118/72a7e152-d0c1-4998-b506-2bc033643fbb)

In conclusion, our simulation employed Assembly Language to power the entire system. By writing Assembly Language code specifically for the 8086 microprocessor, we were able to effectively control the behavior of the system and achieve the desired functionality. The use of Assembly Language provided us with low-level control and optimization opportunities, enabling us to fully utilize the capabilities of the 8086 microprocessor in the simulation.

# Hardware -Arduino UNO, 4x4 Matrix Keypad, I2C LCD Display

In our implementation, we utilized an Arduino Uno microcontroller board to realize the hardware aspects of the system. Arduino Uno is a widely used development board based on the ATmega328P microcontroller, offering a broad range of capabilities and ease of use.

To facilitate user input, we integrated a 4x4 matrix calculator into our system. The 4x4 matrix calculator consists of 16 buttons arranged in a matrix format, enabling users to input numbers, mathematical operations, and other relevant commands. By interfacing this matrix calculator with the Arduino Uno, we were able to capture user input effectively.

For displaying output, we employed an I2C (Inter-Integrated Circuit) LCD display. The I2C protocol provides a simple and efficient way to communicate with peripheral devices, and the LCD module, with its alphanumeric capabilities, allowed us to provide visual feedback to the user. By connecting this display module to the Arduino Uno using the I2C interface, we established seamless communication between the microcontroller and the display.

To program and control the behavior of the system, we utilized the Arduino IDE and coded in C++. The Arduino IDE (Integrated Development Environment) provides a user-friendly platform for writing, compiling, and uploading code to Arduino boards. C++ is the programming language supported by the Arduino IDE, offering a versatile and powerful toolset for creating embedded applications.

In our C++ code, we implemented the necessary routines to handle the matrix calculator inputs. By configuring the appropriate pins of the Arduino Uno as inputs and utilizing suitable digital input/output functions, we were able to detect and process the key presses from the matrix calculator.

We also utilized C++ to communicate with the I2C LCD display. By leveraging the Wire library provided by Arduino, we could send commands and data to the display module, instructing it to show the desired output based on the calculations and results performed by the Arduino Uno.

Overall, the combination of Arduino Uno, the 4x4 matrix calculator, the I2C LCD display, and C++ programming facilitated the implementation of the hardware part of our system. The Arduino Uno served as the central microcontroller, interfacing with the matrix calculator for user input and controlling the I2C LCD display for output. C++ provided a versatile programming language with convenient libraries for efficient development within the Arduino IDE.

![PXL_20230605_065337743](https://github.com/FarhanTahmid/16-bit-Decimal-Calculator-CSE331/assets/62169118/5709560e-d44b-4ec5-a8da-588f1101a339)

In conclusion, our implementation utilized Arduino Uno as the microcontroller board, a 4x4 matrix calculator for user input, an I2C LCD display for output, and C++ as the programming language within the Arduino IDE. This combination allowed us to create a functional system that could receive user input from the matrix calculator, process it using C++ code running on the Arduino Uno, and display the relevant output on the LCD display.
