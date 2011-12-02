// SABERTOOTH MOTOR TEST
// Arduino Duemilanove (tested)
// Gain potentiometer used to test motors on Sabertooth 2x25 using simplified serial mode - jumpers:(101011)
// Potentiometer will determine the speed and direction of both motors. Center 
// 
// In no way to I take responisibility for what you may do with this code! Use at your own risk.
// Test thoroughly with wheels off the ground!
// JD Warren 2011


// use SoftwareSerial library to communicate with the Sabertooth motor-controller
#include <SoftwareSerial.h> 
// define pins used for SoftwareSerial communication
#define rxPin 2
#define txPin 3
// set up a new SoftwareSerial port, named "mySerial" or whatever you want to call it.
SoftwareSerial mySerial =  SoftwareSerial(rxPin, txPin);


// Name Analog input pins
int gainPot = 2;

// Name Digital I/O pins
int ledPin = 13;

// motor speed variables
int motor_out = 0;
int motor_1_out = 0;
int motor_2_out = 0;
int m1_speed = 0;
int m2_speed = 0;
int output;

// potentiometer variables
int gain_reading;
int gain_val;

// end of Variables


void setup(){

  // Start the Serial monitor at 9600bps
  Serial.begin(9600); 
  // define pinModes for tx and rx:
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  // set the data rate for the SoftwareSerial port
  mySerial.begin(9600);

  // Tell Arduino to use the Aref pin for the Analog voltage, don't forget to connect 3.3v to Aref!
  analogReference(EXTERNAL);

}

void loop(){
  // read the values of each potentiomoeter
  read_pots(); 
  // update the motors with the new values
  update_motor_speed();
  // Debug with the Serial monitor
  serial_print_stuff();

}

void read_pots(){
  // Read and convert potentiometer values
  // Gain potentiometer
  gain_reading = analogRead(gainPot);
  gain_val = map(gain_reading, 0, 1023, -63, 63);
}

void update_motor_speed(){
  // Update the motors

    motor_1_out = gain_val;
    motor_2_out = gain_val;

    // test for and correct invalid values
    if(motor_1_out > 63){
      motor_1_out = 63;
    }
    if(motor_1_out < -63){
      motor_1_out = -63;
    }
    if(motor_2_out > 63){
      motor_2_out = 63;
    }
    if(motor_2_out < -63){
      motor_2_out = -63;
    }

    // assign final motor output values
    m1_speed = 64 + motor_1_out;
    m2_speed = 192 + motor_2_out;


  // write the final output values to the Sabertooth via SoftwareSerial
  mySerial.print(m1_speed, BYTE);
  mySerial.print(m2_speed, BYTE);
}


void serial_print_stuff(){
  // Debug with the Serial monitor

   Serial.print("m1/m2: ");
   Serial.print(m1_speed);
   Serial.print("/");
   Serial.println(m2_speed);
}

