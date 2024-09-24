#### KyotoTycoon Installation

install_base_pakage:
  pkg.installed:
    - pkgs:
       - tmpreaper

######################################### Creating Paths
create_/opt/kyototycoon:
  file.directory:
    - name: /opt/kyototycoon/

create_/opt/kyototycoon/db_backup:
  file.directory:
    - name: /opt/kyototycoon/db_backup

create_/etc/kyototycoon:
  file.directory:
    - name: /etc/kyototycoon

create_/opt/kyototycoon/ktbin:
  file.directory:
    - name: /opt/kyototycoon/ktbin

create_/var/log/kyototycoon:
  file.directory:
    - name: /var/log/kyototycoon
    - mode: 644

create_/run/ktserver.pid:
  cmd.run:
     - name: touch /run/ktserver.pid 

create_/var/log/kyototycoon/ktserver.log:
  cmd.run:
     - name: touch /var/log/kyototycoon/ktserver.log ; chmod 644 /var/log/kyototycoon/ktserver.log

######################################### Copying Scripts
/opt/kyototycoon/ktbin/dbbackup:
  file.managed:
    - source: salt://kyototycoon_slave/files/dbbackup
    - mode: 755

/opt/kyototycoon/ktbin/recovery.sh:
  file.managed:
    - source: salt://kyototycoon_slave/files/recovery.sh
    - mode: 755

########################################## Copying Packages and Configurations 
kyotocabinet.deb:
  file.managed:
    - name: /tmp/kyotocabinet_1.2.76-1_amd64.deb
    - source: salt://kyototycoon_slave/files/kyotocabinet_1.2.76-1_amd64.deb

kyotocabinet.install:
  cmd.run:
     - name: cd /tmp/ ; dpkg -i kyotocabinet_1.2.76-1_amd64.deb

kyototycoon.deb:
  file.managed:
    - name: /tmp/kyototycoon_0.9.56-1_amd64.deb
    - source: salt://kyototycoon_slave/files/kyototycoon_0.9.56-1_amd64.deb

kyototycoon.install:
  cmd.run:
     - name: cd /tmp/ ; dpkg -i kyototycoon_0.9.56-1_amd64.deb

loading shared libraries:
  cmd.run:
     - name: ldconfig

/etc/logrotate.d/ktserver-log.conf:
  file.managed:
    - name: /etc/logrotate.d/ktserver-log.conf
    - source: salt://kyototycoon_slave/files/ktserver-log.conf

/etc/kyototycoon/ktserver.conf:
  file.managed:
    - name: /etc/kyototycoon/ktserver.conf
    - source: salt://kyototycoon_slave/files/ktserver.conf

/lib/systemd/system/ktserver.service:
  file.managed:
    - name: /lib/systemd/system/ktserver.service
    - source: salt://kyototycoon_slave/files/ktserver.service

daemon_systemctl_reload:
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: /lib/systemd/system/ktserver.service

#/etc/keepalived/keepalived.sh:
#  file.managed:
#    - name: /etc/keepalived/keepalived.sh
#    - source: salt://kyototycoon_slave/files/keepalived.sh
#    - mode: 755
######################################### KT exporter
kt_exporter_service:
  file.managed:
    - name: /etc/systemd/system/kt_exporter.service
    - source: salt://kyototycoon_slave/files/kt_exporter.service

kt_exporter_binary_file:
 file.managed:
   - name: /usr/local/bin/kyototycoon_exporter
   - source: salt://kyototycoon_slave/files/kt_exporter/kyototycoon_exporter-0.1.0.linux-amd64/kyototycoon_exporter
   - user: root
   - group: root
   - mode: 755

kt_exporter_start_service:
  service.running:
    - name : kt_exporter.service
    - enable: True

ktserver-enable:
  cmd.run:
    - name: systemctl enable ktserver.service 

######################################### Cron Jobs
/etc/cron.d/ktserver:
  file.managed:
    - name: /etc/cron.d/ktserver
    - source: salt://kyototycoon_slave/files/ktserver


