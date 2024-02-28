# 入门指南

## 快速开始

你可以从代码仓库中的示例[`actix-app`]、[`axum-app`]或者[`dioxus-desktop`]开始体验Zino框架。

```bash
git clone https://github.com/zino-rs/zino.git
cd zino/examples/axum-app
cargo run
```

如果你能在终端中看到日志输出，那就表明`axum-app`成功运行了！需要注意的是：
- 当前Zino框架运行在`Rust 1.75+`，请使用[`rustup`]安装合适的版本；
- 示例`axum-app`中需要连接MySQL数据库，具体配置参见[`axum-app/config/config.dev.toml`][axum-app-config]。

[`actix-app`]: https://github.com/zino-rs/zino/tree/main/examples/actix-app
[`axum-app`]: https://github.com/zino-rs/zino/tree/main/examples/axum-app
[`dioxus-desktop`]: https://github.com/zino-rs/zino/tree/main/examples/dioxus-desktop
[`rustup`]: https://rust-lang.github.io/rustup/
[axum-app-config]: https://github.com/zino-rs/zino/blob/main/examples/axum-app/config/config.dev.toml