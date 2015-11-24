Hostname "{{ HOSTNAME | default("tc-microservice-docker") }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5

LoadPlugin disk
LoadPlugin interface
LoadPlugin load
LoadPlugin memory
LoadPlugin cpu
LoadPlugin write_graphite

<Plugin write_graphite>
 <Node "graphite01">
   Host "{{ GRAPHITE_IP }}"
   Port "{{ GRAPHITE_PORT | default("2003") }}"
   Prefix "{{ GRAPHITE_PREFIX | default("collectd.") }}"
   Protocol "tcp"
   #Postfix ""
   #LogSendErrors false
   EscapeCharacter "_"
   SeparateInstances true
   StoreRates false
   AlwaysAppendDS false
 </Node>
</Plugin>








