# 入门指南

## 快速开始

你可以从代码仓库中的示例[`actix-app`]、[`axum-app`]或者[`dioxus-desktop`]开始体验Zino框架。

```bash
git clone https://github.com/zino-rs/zino.git
cd zino/examples/axum-app
cargo run
```

如果你能看到类似于下面的日志输出，那就表明`axum-app`成功运行了！
![截图](https://zino.cc/assets/screenshots/guide-axum-app-log.png)

需要注意的是：
- 当前Zino框架运行在`Rust 1.75+`版本；
- 示例`axum-app`中需要连接MySQL数据库，具体配置参见`axum-app/config/。

[`actix-app`]: https://github.com/zino-rs/zino/tree/main/examples/actix-app
[`axum-app`]: https://github.com/zino-rs/zino/tree/main/examples/axum-app
[`dioxus-desktop`]: https://github.com/zino-rs/zino/tree/main/examples/dioxus-desktop
