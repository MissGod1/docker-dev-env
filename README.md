# 使用

```shell
./run.sh [build|start|remove] [cpu|gpu]
```

- 首次使用首先运行`./run.sh build cpu|gpu`, 根据提示设置ssh与jupyterlab密码
- 执行`./run.sh start cpu|gpu`启动容器
- `ssh`和`jupyterlab`映射端口在`docker-compose.yaml`中的`ports`定义，请自行更改
- 容器运行后将在当前目录下`code`目录挂载到容器中的指定目录，如需更改或者增加挂载目录请自行修改`docker-compose.yaml`中的`volumes`配置