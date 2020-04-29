# -*- coding: utf-8 -*-
#******************************************
# Author:       zhanglong
# Email:        392572435@qq.com
# Organization: https://www.cnblogs.com/chenxiba/
# Description:  Nginx Install
#******************************************
#nginx使用stable版本
{% set nginx_version = "nginx-1.16.1" %}


include:
  - k8s.modules.base-dir
nginx-install:
  file.recurse:
    - name: /usr/local/src/{{ nginx_version }}
    - source: salt://k8s/files/{{ nginx_version }}
    - user: root
    - group: root
    - dir_mode: 755 
    - file_mode: 644  
    - makedirs: True   
  cmd.run:
    - name: yum install -y /usr/local/src/{{ nginx_version }}/*rpm
    - unless: test -e /usr/sbin/nginx
nginx-stream_module:
  file.managed:
    - name: /opt/kubernetes/kube-nginx/modules/ngx_stream_module.so
    - source: salt://k8s/files/{{ nginx_version }}/ngx_stream_module.so
    - user: root
    - group: root
    - mode: 644
nginx-config:
  file.managed:
    - name: /opt/kubernetes/kube-nginx/conf/kube-nginx.conf
    - source: salt://k8s/templates/nginx/kube-nginx.conf.template
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        MASTER_IP_M1: {{ pillar['MASTER_IP_M1'] }}
        MASTER_IP_M2: {{ pillar['MASTER_IP_M2'] }}
        MASTER_IP_M3: {{ pillar['MASTER_IP_M3'] }}
nginx-service:
  file.managed:
    - name: /usr/lib/systemd/system/kube-nginx.service
    - source: salt://k8s/templates/nginx/kube-nginx.service.template
    - user: root
    - group: root
    - mode: 644
    - template: jinja
  service.running:
    - name: kube-nginx
    - enable: True
    - watch:
      - file: nginx-config