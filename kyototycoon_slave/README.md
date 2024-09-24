# This is kyototycoon installation guidance. 

for running this state, you have to use Jenkins interface.

1.Login Jenkins, go to 'Manage Jenkins' ---> 'Configure Syaytems' and add environment variable in 'Global properties' and save.
```
FYI, enter each node's name exactly like its salt name "ir-tcb-e01.digicdn.dev" and for value check the google sheet for uniqueness.
```
2.Then, go to 'kyototycoon' pipline and go to 'configure' and add the new server name to "Server" parameter.

3.Then run the pipeline for that server. TADA

FYI ... Service is not started automatically in this pipeline, you have to make sure that your newly added server, has the latest casket.

```
Run this, after server preperation. 
```
