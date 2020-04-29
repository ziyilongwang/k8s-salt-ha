# -*- coding: utf-8 -*-
#******************************************
# Author:       zhanglong
# Email:        392572435@qq.com
# Organization: http://www.devopsedu.com/
# Description:  Base Env
#******************************************

kubernetes-dir:
  file.directory:
    - name: /opt/kubernetes

kubernetes-bin:
  file.directory:
    - name: /opt/kubernetes/bin

kubernetes-config:
  file.directory:
    - name: /opt/kubernetes/cfg

kubernetes-ssl:
  file.directory:
    - name: /opt/kubernetes/ssl

kubernetes-log:
  file.directory:
    - name: /opt/kubernetes/log

path-env:
  file.append:
    - name: /etc/profile
    - text:
      - export PATH=$PATH:/opt/kubernetes/bin
# nginx 目录创建
nginx-dir:
  file.directory:
    - name: /opt/kubernetes/kube-nginx

nginx-modules:
  file.directory:
    - name: /opt/kubernetes/kube-nginx/modules

nginx-conf:
  file.directory:
    - name: /opt/kubernetes/kube-nginx/conf

init-pkg:
  pkg.installed:
    - names:
      - nfs-utils
      - socat
