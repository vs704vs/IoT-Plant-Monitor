#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include "DHTesp.h"

const char* ssid = "Hotspot";
const char* password = "12345670";

const char* server = "api.thingspeak.com";
const char* apiKey_weather = "EI8NMHXHCRNRY16S"; // Your ThingSpeak API write key for weather data
const char* apiKey_relay = "J2BXJBBW7WYO18GJ";   // Your ThingSpeak API write key for relay control
const int weatherFieldNumber_temp = 1;  // Field number for temperature data
const int weatherFieldNumber_humi = 2;  // Field number for humidity data
const int weatherFieldNumber_moist = 3; // Field number for moisture data
const int relayFieldNumber = 4;          // Field number for relay control

const int sensor_pin = A0;
const uint8_t relayPin = 5;

DHTesp dht;
WiFiClient client;

void connectToWiFi() {
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

void readAndSendWeatherData() {
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

  // Prepare URL for ThingSpeak weather data
  String url_weather = "/update?api_key=";
  url_weather += apiKey_weather;
  url_weather += "&field1=";
  url_weather += String(tempC);
  url_weather += "&field2=";
  url_weather += String(humi);
  url_weather += "&field3=";
  url_weather += String(moisture_percentage);

  sendToThingSpeak(server, url_weather);
}

void controlRelay() {
  // Make an HTTP request to ThingSpeak to retrieve the latest relay control data
  String url_relay = "/channels/2505530/fields/" + String(relayFieldNumber) + "/last?key=" + String(apiKey_relay);
  String response = getRequest(server, url_relay);

  // Parse the response to extract the relay control value
  int startIndex = response.lastIndexOf('N') + 2;
  String valueStr = response.substring(startIndex);
  int value = valueStr.toInt();

  // Perform action based on the relay control value
  if (value == 0) {
    digitalWrite(relayPin, LOW); // Turn off the relay
    Serial.println("Relay OFF");
  } else if (value == 1) {
    digitalWrite(relayPin, HIGH); // Turn on the relay
    Serial.println("Relay ON");
  } else {
    Serial.println("Unknown relay control value");
  }
}

String getRequest(const char* host, String url) {
  WiFiClient client;
  const int httpPort = 80;
  String response = "";

  if (!client.connect(host, httpPort)) {
    Serial.println("Connection to ThingSpeak failed");
    return response;
  }

  Serial.print("Requesting URL: ");
  Serial.println(url);
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");

  // Read the HTTP response
  while (client.connected() && !client.available())
    delay(1);

  while (client.available()) {
    String line = client.readStringUntil('\r');
    response += line;
  }

  Serial.println("Response:");
  Serial.println(response);

  return response;
}

void sendToThingSpeak(const char* host, String url) {
  Serial.print("Connecting to ");
  Serial.println(host);

  if (client.connect(host, 80)) {
    Serial.println("Connected to server");
    client.print(String("GET ") + url + " HTTP/1.1\r\n" + "Host: " + host + "\r\n");
    client.print("Connection: close\r\n\r\n");
    delay(500);
    client.stop();
    Serial.println("Data sent to ThingSpeak");
  } else {
    Serial.println("Connection to server failed");
  }
}

void setup() {
  Serial.begin(9600);
  delay(10);

  dht.setup(2, DHTesp::DHT11);

  // Connect to WiFi
  connectToWiFi();

  // Set the relay pin as an output
  pinMode(relayPin, OUTPUT);
}

void loop() {
  // Read and send weather data to ThingSpeak
  readAndSendWeatherData();

  // Control the relay based on ThingSpeak data
  controlRelay();

  delay(15000);  // Adjust interval as needed
}
