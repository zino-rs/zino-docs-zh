# 目录结构

> Zino开发框架的应用目录组织方式只是一种推荐，可根据实际需求进行调整。尤其是`src`目录，可以使用Rust模块自由组织，
  我们并没有严格限定各个模块之间的调用关系。

我们采用了类似于[Egg.js][eggjs-structure]的应用目录约定规范：

```shell
zino-app
├─ Cargo.toml
├─ config
│  ├─ config.dev.toml
│  ├─ config.prod.toml
│  ├─ locale
│  │  ├─ en-US.ftl
│  │  └─ zh-CN.ftl
│  └─ openapi
│     ├─ OPENAPI.toml
│     ├─ auth.toml
│     └─ user.toml
├─ local
│  ├─ data
│  │  └─ mock
│  │     ├─ logs.ndjson
│  │     └─ users.csv
│  └─ docs
│     └─ rapidoc.html
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
│  ├─ extension
│  │  ├─ casbin.rs
│  │  ├─ header.rs
│  │  └─ mod.rs
│  ├─ logic
│  │  ├─ mod.rs
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
* `config/locale/{lang-id}.ftl`于编写i18n多语言文件（目前仅支持[`Fluent`]规范）。
* `config/openapi/`用于编写OpenAPI规范文档。
* `local/`为本地静态资源目录（不能通过网络访问），`data/`为本地数据目录，`docs/`为文档目录。
* `logs/`用于日志文件输出。
* `public/`为通过网络访问的静态资源目录，`index.html`为默认首页文件，`404.html`为404文件，`data/`为共享的数据目录。
* `src/controller/`用于编写控制器。
* `src/extension/`用于编写辅助函数。
* `src/logic/`用于编写业务逻辑。
* `src/main.rs`用于启动应用以及自定义初始化。
* `src/middleware/`用于编写中间件。
* `src/router/`用于配置URL路由规则。
* `src/schedule/`用于编写定时任务。
* `src/service/`用于编写业务接口服务，供`controller`调用。
* `templates/`用于编写HTML模板文件（目前支持[`Tera`]和[`MiniJinja`]模板）。

[eggjs-structure]: https://www.eggjs.org/zh-CN/basics/structure
[`Fluent`]: https://projectfluent.org/
[`Tera`]: https://docs.rs/tera
[`MiniJinja`]: https://docs.rs/minijinja
