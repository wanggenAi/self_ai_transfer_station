# self_ai_transfer_station

本仓库用于本地部署 `Wei-Shaw/sub2api`，已内置可直接运行的 Docker Compose 部署包。

## 部署目录

请在 `sub2api-deploy/` 下执行所有运维命令。

## 环境要求

- macOS / Linux
- Docker Desktop（或可用的 Docker Engine + Docker Compose）

## 快速开始（首次）

```bash
cd sub2api-deploy
./scripts/init-env.sh
./scripts/up.sh
```

初始化完成后访问：

- http://localhost:8080

## 日常操作

```bash
cd sub2api-deploy
```

- 启动服务：`./scripts/up.sh`
- 停止服务：`./scripts/down.sh`
- 查看状态：`./scripts/status.sh`
- 查看全部日志：`./scripts/logs.sh`
- 查看单服务日志：`./scripts/logs.sh sub2api`
- 查看初始管理员信息：`./scripts/admin-creds.sh`

## 安全默认值

- 默认只绑定本机：`BIND_HOST=127.0.0.1`
- `init-env.sh` 会自动生成强随机密钥（Postgres/Redis/JWT/TOTP）
- `.env` 和运行数据目录均被 `.gitignore` 忽略，不会提交到仓库

## 目录结构

```text
self_ai_transfer_station/
└── sub2api-deploy/
    ├── docker-compose.local.yml
    ├── scripts/
    │   ├── init-env.sh
    │   ├── up.sh
    │   ├── down.sh
    │   ├── status.sh
    │   ├── logs.sh
    │   └── admin-creds.sh
    └── README.md
```

## 说明文档

更细粒度配置说明见：

- `sub2api-deploy/README.md`
