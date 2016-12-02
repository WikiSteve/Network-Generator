#!/bin/bash
# Date:   Dec 1, 2016
# GitHub: https://github.com/WikiSteve 
#         Steve (AT) WikiSteve (DOT) com
# Converts L2 & L3 destination information from a pcap file
# for the purpose of network generation towards a specific target

CAPFILES=./*.cap
PCAPFILES=./*.pcap
echo "WARNING: All *.cap *.pcap files will be overwritten, no backups made"
echo "failed conversions will be deleted"
echo ""
echo "Layer 2 information required for first hop"
echo "Layer 3 information required for final destination"
echo ""
echo "Enter L2 MAC in format AA:BB:CC:DD:EE:FF" 
read mac_address
echo "Enter L3 IP address"
read ip_address

for f in $CAPFILES
do
  echo "Processing $f file..."
  bittwiste -I $f -O tmp.cap  -T ip -d $ip_address
  bittwiste -I tmp.cap -O $f  -T eth -d $mac_address
  echo "done with $f"
  echo ""
done

for f in $PCAPFILES
do
  echo "Processing $f file..."
  bittwiste -I $f -O tmp.pcap  -T ip -d $ip_address
  bittwiste -I tmp.pcap -O $f  -T eth -d $mac_address
  echo "done with $f"
  echo ""
done

#cleaning up
rm tmp.cap
rm tmp.pcap
