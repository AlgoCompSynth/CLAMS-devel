#include <AMY-Arduino.h>
#include <I2S.h>

I2S i2s(OUTPUT);
AMY amy;

void setup() {

  // Set your I2S pins. 
  // Pico Audio Pack
  i2s.setBCLK(10); // BCLK = SCLK. LRCLK = SCLK + 1
  i2s.setDATA(9); // DATA = DIN, SD, SDOUT, DOUT
  i2s.setBitsPerSample(16); 
  i2s.setBuffers(2, AMY_BLOCK_SIZE*AMY_NCHANS*AMY_BYTES_PER_SAMPLE/2, 0);
  i2s.begin(AMY_SAMPLE_RATE);


  Serial.begin(115200);
  while (!Serial && millis() < 10000UL);
  Serial.println("Welcome to AMY example");

  // Start up AMY
  amy.begin(1, 0, 0, 0);

  // Send AMY messages in two ways: first, using the wire protocol:
  // This sends a sine wave at 220Hz on osc 0 with velocity 1
  amy.send_message((char*)"v0f220l1");
  
  // The second way is to use the structure directly 
  // We fill in an event struct with what we want and "schedule" it for 2.5 seconds from now
  long clock = amy.sysclock();
  struct event e = amy.default_event();
  e.osc = 0;
  e.wave = SINE;
  e.freq_coefs[COEF_CONST] = 440;
  e.velocity = 1;
  e.time = clock+2500;
  amy.add_event(e);
   
  // Run an example script to start 5s from now
  amy.drums(clock+5000, 2);
}


void loop() {
  // In your loop you have to get the buffer of samples and then play it out your device
  int16_t * samples = (int16_t*)amy.render_to_buffer();
  for(uint16_t i=0;i<AMY_BLOCK_SIZE;i++) {
    i2s.write16(samples[i], samples[i]);
  }
}

