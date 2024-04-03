# 创建应用

我们使用Rust的构建工具`Cargo`来管理应用。首先新建一个项目
```bash
cargo new zino-app --bin
```
然后在`Cargo.toml`中添加以下依赖
```toml
[package]
name = "zino-app"
version = "0.1.0"
edition = "2021"

[dependencies]
zino = { version = "0.20", features = ["axum"] }
```
这里我们使用的是`axum`框架。如果要用`actix-web`框架，那就把`features`替换为`["actix"]`。
进而，我们在`src`目录的`main.rs`中添加以下代码：
```rust
use zino::prelude::*;

fn main() {
    zino::Cluster::boot().run()
}
```
此时，我们的应用已经可以运行了：
```bash
cargo run
```
打开浏览器地址`http://localhost:6080/rapidoc`，你将能够看到RapiDoc文档页面。

这是一个极简的示例，没有太多实际功能。但是如果你在项目目录中添加一个`public`目录，那么这就可以作为静态文件服务器，
并且Zino框架会自动使用`public/index.html`来渲染根路由`/`。在前后端分离的项目中，这一特性可用于部署打包后的单页面应用。