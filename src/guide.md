# 入门指南

## 快速开始

你可以通过[`actix-app`]、[`axum-app`]或者[`dioxus-desktop`]快速开始体验zino框架。
当前我们需要使用**nightly**来构建项目。

```shell
git clone https://github.com/photino/zino.git
cd zino/examples/axum-app
cargo run -- --env=dev
```

运行后终端会显示

```shell
2023-10-07T21:17:13.3932278+08:00  WARN zino::application::actix_cluster: listen on 127.0.0.1:6070, server_name: "debug", app_env: "dev", app_name: "data-cube", app_version: "0.6.3"
    at D:\work\RustProject\zino\zino\src\application\actix_cluster.rs:69

  2023-10-07T21:17:13.3942731+08:00  INFO actix_server::builder: starting 8 workers
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\builder.rs:200

  2023-10-07T21:17:13.3947248+08:00  WARN zino::application::actix_cluster: listen on 127.0.0.1:6080, server_name: "main", app_env: "dev", app_name: "data-cube", app_version: "0.6.3"
    at D:\work\RustProject\zino\zino\src\application\actix_cluster.rs:69

  2023-10-07T21:17:13.3955543+08:00  INFO actix_server::builder: starting 8 workers
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\builder.rs:200

  2023-10-07T21:17:13.3959588+08:00  WARN zino::application::actix_cluster: listen on 127.0.0.1:6081, server_name: "portal", app_env: "dev", app_name: "data-cube", app_version: "0.6.3"
    at D:\work\RustProject\zino\zino\src\application\actix_cluster.rs:69

  2023-10-07T21:17:13.396638+08:00  INFO actix_server::builder: starting 8 workers
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\builder.rs:200

  2023-10-07T21:17:13.3970283+08:00  WARN zino::application::actix_cluster: listen on 127.0.0.1:6082, server_name: "admin", app_env: "dev", app_name: "data-cube", app_version: "0.6.3"
    at D:\work\RustProject\zino\zino\src\application\actix_cluster.rs:69

  2023-10-07T21:17:13.3977332+08:00  INFO actix_server::builder: starting 8 workers
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\builder.rs:200

  2023-10-07T21:17:13.3982643+08:00  INFO actix_server::server: Tokio runtime found; starting in existing Tokio runtime
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\server.rs:197

  2023-10-07T21:17:13.4751869+08:00  INFO actix_server::server: Tokio runtime found; starting in existing Tokio runtime
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\server.rs:197

  2023-10-07T21:17:13.5275609+08:00  INFO actix_server::server: Tokio runtime found; starting in existing Tokio runtime
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\server.rs:197

  2023-10-07T21:17:13.578681+08:00  INFO actix_server::server: Tokio runtime found; starting in existing Tokio runtime
    at C:\Users\msjy\.cargo\registry\src\mirrors.ustc.edu.cn-12df342d903acd47\actix-server-2.2.0\src\server.rs:197

  2023-10-07T21:19:02.0365949+08:00  WARN zino_core::state: `config.dev.toml` loaded, env: "dev"
    at D:\work\RustProject\zino\zino-core\src\state\mod.rs:44
    in zino::middleware::actix_tracing::HTTP request with otel.kind: "server", otel.name: "data-cube", url.path: "/public/data/logs.ndjson", http.route: "/public", http.request.method: "GET", client.address: "127.0.0.1", user_agent.original: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.55"
```

直接访问<http://localhost:6080/public/upload.html>
浏览器显示

![网页显示内容](./images/image.png)

至此我们的应用程序就算是搭建成功，后续就可以制作我们自己的应用程序了.

## 注意事项

目前暂时没有构建工具，新建项目推荐大家下载使用**examples**中的例子修改依赖来使用，
选择自己想要使用的**examples**删除其中**Cargo.toml**中的路径依赖就可以愉快的使用了。

[`actix-app`]: https://github.com/photino/zino/tree/main/examples/actix-app
[`axum-app`]: https://github.com/photino/zino/tree/main/examples/axum-app
[`dioxus-desktop`]: https://github.com/photino/zino/tree/main/examples/dioxus-desktop
