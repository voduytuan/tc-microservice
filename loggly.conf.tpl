### Syslog-ng Logging Directives for Loggly.com ###
source s_loggly {
	#system();	# Check which OS & collect system logs
	#internal();	# Collect syslog-ng logs
};

template LogglyFormat { template("<${PRI}>1 ${ISODATE} ${HOST} ${PROGRAM} ${PID} ${MSGID} [{{ LOGGLY_TOKEN }}@41058 tag=\"{{ LOGGLY_TAG | default("Microservice") }}\" ] $MSG\n");
	template_escape(no);
};

destination d_loggly {
	tcp("logs-01.loggly.com" port(514) template(LogglyFormat));
};

log { 
	source(s_loggly); 
	destination(d_loggly); 
};
### END Syslog-ng Logging Directives for Loggly.com ###
