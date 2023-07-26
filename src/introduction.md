# 引言

[`Zino`][zino]致力于打造[Rust][rust]语言中最好用的企业级应用开发框架。
我们借鉴Node的[`Egg.js`][eggjs]以及Java的[`Spring Boot`][spring-boot]等框架，
奉行『约定优于配置』的原则，提供开箱即用的功能模块，极大提高开发效率；
并通过与Rust的[`axum`][axum]、[`actix-web`][actix-web]等框架集成，打通社区生态资源。

![Star History Chart](https://api.star-history.com/svg?repos=photino/zino&type=Timeline)

[rust]: https://www.rust-lang.org/
[zino]: https://github.com/photino/zino
[eggjs]: https://www.eggjs.org/
[spring-boot]: https://spring.io/projects/spring-boot
[axum]: https://crates.io/crates/axum
[actix-web]: https://crates.io/crates/actix-web

## 快速开始

你可以通过 [`actix-app`] 或者 [`axum-app`]快速开始体验zino框架。需要注意的是当前它仍旧需要使用**nightly**来构建项目.

```shell
git clone https://github.com/photino/zino.git
cd zino
cd examples/axum-app
## 编译的时间可能比较漫长，需要耐心等待
cargo run -- --env=dev
```

经过编译整个例子就可以运行了

```shell
......
Finished dev [unoptimized + debuginfo] target(s) in 4m 51s
     Running `D:\work\RustProject\zino\examples\target\debug\axum-app.exe --env=dev`
  2023-07-26T20:25:49.3394964+08:00  WARN zino_core::application::metrics_exporter: listen on 127.0.0.1:9000, exporter: "prometheus"
    at D:\work\RustProject\zino\zino-core\src\application\metrics_exporter.rs:26

  2023-07-26T20:25:49.5679675+08:00  WARN zino::cluster::axum_cluster: listen on 127.0.0.1:6080, env: "dev", name: "data-cube", version: "0.6.0"
    at D:\work\RustProject\zino\zino\src\cluster\axum_cluster.rs:158

  2023-07-26T20:25:49.5704537+08:00  WARN zino::cluster::axum_cluster: listen on 127.0.0.1:6081, env: "dev", name: "data-cube", version: "0.6.0"
    at D:\work\RustProject\zino\zino\src\cluster\axum_cluster.rs:158

  2023-07-26T20:25:49.5727343+08:00  WARN zino::cluster::axum_cluster: listen on 127.0.0.1:6082, env: "dev", name: "data-cube", version: "0.6.0"
    at D:\work\RustProject\zino\zino\src\cluster\axum_cluster.rs:158
```

### 注意事项

目前暂时没有构建工具，新建项目推荐大家下载使用**examples**中的例子修改依赖来使用,选择自己想要使用的**examples**删除其中**Cargo.toml**中的路径依赖就可以愉快的使用了.
