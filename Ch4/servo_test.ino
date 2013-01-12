// Test Servo motors on pins 9 and 10

// servo motor declaration
int servo_left = 9;
int servo_right = 10;

// set stop points for left and right servo motors
int left_stop_val = 1500;
int right_stop_val = 1500;

void setup()
{
  Serial.begin(9600); // start serial monitor to see sensor readings
  // declare left motor 
  pinMode(servo_left, OUTPUT);
  // declare right motor
  pinMode(servo_right, OUTPUT);
}

void loop(){
  servo_left_drive(2000);
  servo_right_drive(2000);
  delay(2000);
  servo_left_stop();
  servo_right_stop();
  delay(2000);
  servo_left_drive(1000);
  servo_right_drive(1000);
  delay(2000);
  servo_left_stop();
  servo_right_stop();
  delay(2000);
}


void servo_left_drive(int speed_val){
  digitalWrite(servo_left, HIGH);
  delayMicroseconds(speed_val);
  digitalWrite(servo_left, LOW);
}

void servo_right_drive(int speed_val){
  digitalWrite(servo_right, HIGH);
  delayMicroseconds(speed_val);
  digitalWrite(servo_right, LOW);
}

void servo_left_stop(){
  digitalWrite(servo_left, HIGH);
  delayMicroseconds(right_stop_val);
  digitalWrite(servo_left, LOW);
}

void servo_right_stop(){
  digitalWrite(servo_right, HIGH);
  delayMicroseconds(left_stop_val);
  digitalWrite(servo_right, LOW);
}
