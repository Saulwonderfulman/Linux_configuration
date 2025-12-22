# 定期备份数据
0 3 * * 1 rsync -a --delete /M.2硬盘路径/ /机械硬盘路径/

#crontab每周一凌晨3点进行备份



