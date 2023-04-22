# 目录结构

Zino开发框架采用了类似于[Egg.js][eggjs-structure]的应用目录约定规范：

```shell
axum-app
├─ Cargo.toml
├─ config
│  ├─ config.dev.toml
│  ├─ config.prod.toml
│  └─ locale
│     ├─ en-US.ftl
│     └─ zh-CN.ftl
├─ data
│  └─ mock
│     ├─ logs.ndjson
│     └─ users.csv
├─ logs
├─ public
│  ├─ 404.html
│  ├─ data
│  │  └─ logs.ndjson
│  └─ index.html
├─ src
│  ├─ controller
│  │  ├─ mod.rs
│  │  ├─ stats.rs
│  │  ├─ task.rs
│  │  └─ user.rs
│  ├─ main.rs
│  ├─ middleware
│  │  ├─ access.rs
│  │  └─ mod.rs
│  ├─ router
│  │  └─ mod.rs
│  ├─ schedule
│  │  ├─ job.rs
│  │  └─ mod.rs
│  └─ service
│     ├─ mod.rs
│     ├─ task.rs
│     └─ user.rs
└─ templates
   ├─ layout.html
   └─ output.html
```

* `Cargo.toml`为应用的Cargo配置文件。
* `config/config.{env}.toml`用于编写不同运行环境的配置文件。
* `config/locale/{lang-id}.ftl`于编写i18n多语言文件（目前仅支持Fluent规范）。
* `data/`用于放置本地数据文件（不能通过网络访问）。
* `logs/`用于日志文件输出。
* `public/`为通过网络访问的静态资源目录，`index.html`为默认首页文件，`404.html`为404文件，`data/`为共享的数据目录。
* `src/controller/`用于编写控制器。
* `src/main.rs`用于启动应用。
* `src/middleware/`用于编写中间件。
* `src/router/`用于配置URL路由规则。
* `src/schedule/`用于编写定时任务。
* `src/service/`用于编写业务逻辑层。
* `templates/`用于编写HTML模板文件（目前仅支持Tera模板）。

[eggjs-structure]: https://www.eggjs.org/zh-CN/basics/structure
