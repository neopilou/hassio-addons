package main

import (
	"log"
	"flag"
	"net/url"
	"time"
	"strconv"
	"github.com/huin/goupnp/dcps/internetgateway1"
	MQTT "github.com/eclipse/paho.mqtt.golang"
)

/*
Options:
 [-help]                      Display help
 [-router <url>]			  URL to router's UPnp XML
 [-user <user>]               User
 [-password <password>]       Password
 [-broker <uri>]              Broker URI
 [-topic <topic>]             Topic
*/

func main() {
	topic := flag.String("topic", "", "The topic name to publish/subscribe")
	broker := flag.String("broker", "tcp://localhost:1883", "The broker URI. ex: tcp://10.10.1.1:1883")
	password := flag.String("password", "", "The MQTT password (optional)")
	user := flag.String("user", "", "The MQTT User (optional)")
	router := flag.String("router", "", "The URL to router's UPnP XML")
	flag.Parse()
	
    var a, b, c, d, e, f float64 = 0, 0, 0, 0, 0, 0
	var x bool = true
	opts := MQTT.NewClientOptions()
	opts.AddBroker(*broker)
	opts.SetClientID("hass")
	opts.SetUsername(*user)
	opts.SetPassword(*password)
	routerPath, err := url.Parse(*router)
	if err != nil {
		log.Fatal(err)
	}

	clients, err := internetgateway1.NewWANCommonInterfaceConfig1ClientsByURL(routerPath)
	if err != nil {
		log.Fatal("Error discovering service with UPnP:", err)
	}
	
	mqttclient := MQTT.NewClient(opts)
	

	for x == true {
		for _, client := range clients {
			if recv, err := client.GetTotalBytesReceived(); err != nil {
				log.Println("Error requesting bytes received:", err)
			} else {
				a = float64(recv)
			}
			time.Sleep(time.Second)
			if recv, err := client.GetTotalBytesReceived(); err != nil {
				log.Println("Error requesting bytes received:", err)
			} else {
				b = float64(recv)
			}
			c = (b - a) * 8 / 1000 / 1000
			log.Println("Receive Mb/s:", c)

			if sent, err := client.GetTotalBytesSent(); err != nil {
				log.Println("Error requesting bytes sent:", err)
			} else {
				d = float64(sent)
			}
			time.Sleep(time.Second)
			if sent, err := client.GetTotalBytesSent(); err != nil {
				log.Println("Error requesting bytes sent:", err)
			} else {
				e = float64(sent)
			}
			f = (e - d) * 8 / 1000 / 1000
			log.Println("Sent Mb/s:", f)
			
			log.Println("---- doing publish ----")
			if token := mqttclient.Connect(); token.Wait() && token.Error() != nil {
				panic(token.Error())
			}
			token := mqttclient.Publish(*topic + "/txbs", 0, false, strconv.FormatFloat(f, 'f', 6, 64))	
			token = mqttclient.Publish(*topic + "/rxbs", 0, false, strconv.FormatFloat(c, 'f', 6, 64))		
			token.Wait()
		}
	}
}