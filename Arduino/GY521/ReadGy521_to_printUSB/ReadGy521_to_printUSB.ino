#include <Wire.h>

const int8_t AddressGY521=B01101000; //7-битный адрес GY-521


void setup() {
pinMode(2,INPUT); 
//настройки и конфигурация
Wire.begin();//запуск связи с датчиком
Wire.beginTransmission(AddressGY521);// Обращаемся к датчику
Wire.write(0x6B); //адрес регистра 
Wire.write(0x00); // выводим устройство из спячки
Wire.endTransmission(true);//заканчиваем передачу информации и отправляем стоповый бит

//настройка гироскопа
Wire.beginTransmission(AddressGY521);// Обращаемся к датчику
Wire.write(0x1B); //адрес регистра 
Wire.write(B00011000); //  =+-2000 град/с
Wire.endTransmission(true);//заканчиваем передачу информации и отправляем стоповый бит

// настройка считывания данных с датчика
Wire.beginTransmission(AddressGY521);// Обращаемся к датчику
Wire.write(0x1A); //адрес регистра 
Wire.write(1); // Fтакт=1 кГц
Wire.endTransmission(true);//заканчиваем передачу информации и отправляем стоповый бит

Wire.beginTransmission(AddressGY521);// Обращаемся к датчику
Wire.write(0x19); //адрес регистра 
Wire.write(99); // Fд=Fтакт/100= кГц
Wire.endTransmission(true);//заканчиваем передачу информации и отправляем стоповый бит

// настройки прерывания
Wire.beginTransmission(AddressGY521);// Обращаемся к датчику
Wire.write(0x37); //адрес регистра 
Wire.write(B10111000); // прерывания - LOW уровень сигнала
Wire.endTransmission(true);//заканчиваем передачу информации и отправляем стоповый бит

Wire.beginTransmission(AddressGY521);// Обращаемся к датчику
Wire.write(0x38); //адрес регистра 
Wire.write(1); // источник прерывания - запись в регистр
Wire.endTransmission(true);//заканчиваем передачу информации и отправляем стоповый бит

Serial.begin(9600);
}

void loop() {
if(digitalRead(2)==0) { 
  Wire.beginTransmission(AddressGY521);
  Wire.write(0x47);//адрес регистра
  Wire.endTransmission(false);// удержка связи
  Wire.requestFrom(AddressGY521, 2, true);
  Serial.println((Wire.read()<<8)|Wire.read());
  }

}


