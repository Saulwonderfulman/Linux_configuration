# nextcloud安装




# nextcloud配置
## 设置不限制ip访问
```
sudo docker exec --user www-data nextcloud-docker-app-1 php occ config:system:set trusted_domains 1 --value="*.*.*.*:8080"
```


## 安装扩展应用
https://memories.gallery/










