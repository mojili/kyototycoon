copy_db:
  file.managed:
    - name: /opt/kyototycoon/casket-0001.kch
    - source: salt://kt_db_transfer/files/casket-0001.kch

ktserver_start_service:
  service.running:
    - name : ktserver.service
    - enable: True


