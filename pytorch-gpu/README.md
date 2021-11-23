# 使用

```shell
./run.sh [build|up|down|ps] [-d]
```
- 使用前请在`docker-compose.yaml`中设置将要使用的用户名与密码
- 执行`./run.sh up`启动容器, 使用`up`时可以添加额外参数`-d`后台启动容器
- `ssh`映射端口在`docker-compose.yaml`中的`ports`定义，具体格式参照官方文档(默认为随机映射,启动后执行`./run.sh ps`查看)
- 挂载目录可以在`docker-compose.yaml`中`volumns`中添加，具体格式参照官方文档