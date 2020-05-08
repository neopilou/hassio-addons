#!/usr/bin/python

import sys, getopt, paho.mqtt.client as mqtt

def main(argv):
	url = ''
	port = 1883
	user = ''
	pwd = ''
	topic= ''
	txbs = ''
	rxbs = ''
   
	try:
		opts, args = getopt.getopt(argv,"hu:p:l:m:o:t:r",["url=","port=", "user=","pwd=","topic","txbs=","rxbs="])
	except getopt.GetoptError:
		print ('pub.py -u <url> -p <port> -l <username> -m <password> -o <topic> -t <txbs> -r <rxbs>')
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			print ('pub.py -u <url> -p <port> -l <username> -m <password> -o <topic> -t <txbs> -r <rxbs>')
			sys.exit()
		elif opt in ("-u", "--url"):
			url = arg
		elif opt in ("-p", "--port"):
			port = arg
		elif opt in ("-l", "--user"):
			user = arg
		elif opt in ("-m", "--pwd"):
			pwd = arg
		elif opt in ("-o", "--topic"):
			topic = arg
		elif opt in ("-t", "--txbs"):
			txbs = arg
		elif opt in ("-r", "--rxbs"):
			rxbs = arg

	mqttc = mqtt.Client("netgear")  # Create instance of client with client ID “digitest”
	mqttc.username_pw_set(user, pwd)
	mqttc.connect(url, int(port))  # Connect to (broker, port, keepalive-time)
	mqttc.loop_start()  # Start networking daemon
	mqttc.publish(topic + "/txbs", txbs)  # Publish message to “digitest /test1” topic
	mqttc.loop_stop()  # Kill networking daemon

if __name__ == "__main__":
	main(sys.argv[1:])