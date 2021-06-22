
## Virtual Security Operation Center
### DefAtt-SOC
To recreate the concept of the SOC in a virtualized environment
as realistic as possible the proposed architecture
of the systems with several tools utilized. The whole SOC functionality was enclosed in
a virtual machine that can be easily spawn and destroyed
according to the needs. Subsequently, in figure is
the representation of the Virtual workflow that was established
for the SOC.


A **Security Operation Center** is defined by 4 crucial steps that are behind all the
logic and functionality. These steps are briefly described
nextly, while afterwards their integration with the platform
itself is detailed.

1. **Collection** - It is the step where all the events from the
   infrastructure are sent.
2. **Detection** - After the events are available, it is important to
   see if something consists of a security incident.
3. **Analyzing** - Locate and identify the threat that is raising an
   alarm.
4. **Solution** - Initiated necessary countermeasure.






![defattSoc](http://cybertraining.dk/NAP%20Architecture%20-%20Copy%20of%20SoC-Blue.jpeg)









###Powered by Docker-compose
**ELK-Stack(Elastic-Logstash-Kibana); ElastAlert; Wireshark; TheHive**