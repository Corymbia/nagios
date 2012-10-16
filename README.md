nagios
======

### check-azs

###### Check an availability zone of Eucalyptus cloud and produce alerts in Nagios

This command may either be run with NRPE or on the Nagios server as long as the credentials are available to the script.

The script defaults to looking for administrator credentials in /etc/euca/eucarc but the user may supply a value by using the '-a' command flag. Make sure that the credentials are readable by the NRPE daemon or Nagios.

The script allows the user to pass values that should be used when determining if an alert should be made and what the severity should be. The script will alert based on the number of available instances (use the "-i" flag) for each VM type (m1.small, c1.medium, m1.large, m1.xlarge, and c1.xlarge) or the percentage of each available VM type (the default behavior). If these values are less than or equal to the supplied values then the appropriate alert is issued.

When specifying the values to alert on use a comma separated list. These lists are in the form,
```
<m1.small>,<c1.medium>,<m1.large>,<m1.xlarge>,<c1.xlarge>
```
Each value above will be a percentage in decimal form in the default mode. If the "-i" flag is used, each value above will be an integer. If you do not wish to check a VM type, a value of -1 may be used.

For example, the following are valid executions of the script:
```
./check-azs -w .25,.22,.20,.15,.10 -c .15,.12,.10,.8,.5
```
or
```
./check-azs -i -w 4,2,2,1,-1 -c 2,1,1,0,-1
```
