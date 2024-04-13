#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include "DHTesp.h"

#ifdef ESP32
#pragma message(THIS EXAMPLE IS FOR ESP8266 ONLY !)
#error Select ESP8266 board.
#endif

const int sensor_pin = A0;
const char* ssid = "Hotspot";       // Your WiFi SSID
const char* password = "12345670";  // Your WiFi password

const char* server = "api.thingspeak.com";  // ThingSpeak API server
const char* apiKey = "WV21A4ZVS3Q6SQX5";    // Your ThingSpeak API write key

DHTesp dht;

WiFiClient client;



void setup() {
  Serial.begin(9600);
  delay(10);

  dht.setup(2, DHTesp::DHT11);
  // Connect to WiFi
  Serial.println();
  Serial.println("Attempting to connect to WiFi...");
  Serial.print("SSID: ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  int attempt = 0;
  while (WiFi.status() != WL_CONNECTED && attempt < 20) {
    delay(500);
    Serial.print(".");
    attempt++;
  }

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("");
    Serial.println("WiFi connected");
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.println("");
    Serial.println("Failed to connect to WiFi. Check your credentials or signal strength.");
  }
}

void loop() {

  delay(dht.getMinimumSamplingPeriod());


  float humi = dht.getHumidity();
  float tempC = dht.getTemperature();

  float moisture_percentage;
  int sensor_analog;
  sensor_analog = analogRead(sensor_pin);
  moisture_percentage = (100 - ((sensor_analog / 1023.00) * 100));
  Serial.print("Moisture Percentage = ");
  Serial.print(moisture_percentage);
  Serial.print("%\n");
  Serial.print("Temperature = ");
  Serial.print(tempC);
  Serial.print(" C\n");
  Serial.print("Humidity = ");
  Serial.print(humi);
  Serial.print(" %\n");



  // Prepare URL for ThingSpeak
  String url = "/update?api_key=";
  url += apiKey;

    String url_data = url + "&field1=" + String(tempC) + "&field2=" + String(humi) + "&field3=" + String(moisture_percentage);

  // String url_moisture = url + "&field3=";
  // url_moisture += String(moisture_percentage);

  // String url_temp = url + "&field1=";
  // url_temp += String(tempC);

  // String url_humi = url + "&field2=";
  // url_humi += String(humi);

  Serial.print("Connecting to ");
  Serial.println(server);

  // Send data to ThingSpeak
  if (client.connect(server, 80)) {
    Serial.println("Connected to server");
    client.print(String("GET ") + url_data + " HTTP/1.1\r\n" + "Host: " + server + "\r\n");
    

    client.print("Connection: close\r\n\r\n");
    delay(500);
    client.stop();
    Serial.println("Data sent to ThingSpeak");
  } else {
    Serial.println("Connection to server failed");
  }




  delay(15000);  // ThingSpeak update interval (in milliseconds), adjust as needed
}
