Hostname "{{ HOSTNAME | default("tc-microservice-docker") }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5

LoadPlugin cpu
LoadPlugin disk
LoadPlugin interface
LoadPlugin load
LoadPlugin memory
LoadPlugin cpu
LoadPlugin network

<Plugin network>
  Server "{{ COLLECTD_IP }}" "{{ COLLECTD_PORT | default("25826") }}"
</Plugin>







