# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import socket



msgFromClient       = "Hello UDP Server"

bytesToSend         = str.encode(msgFromClient)

serverAddressPort   = ("172.17.0.2", 8080 )

bufferSize          = 1024



# Create a UDP socket at client side

UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)



# Send to server using created UDP socket

UDPClientSocket.sendto(bytesToSend, serverAddressPort)



msgFromServer = UDPClientSocket.recvfrom(bufferSize)



msg = "Message from Server {}".format(msgFromServer[0])

print(msg)

print("finished!")