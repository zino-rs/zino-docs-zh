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
axum = "0.6.20"
serde = { version = "1.0.197", features = ["derive"] }
tracing = "0.1.40"
zino = { version = "0.18.2", features = ["axum"] }
zino-core = { version = "0.19.2", features = ["orm-mysql"] }
zino-derive = "0.16.2"
zino-model = "0.16.2"
```
这里我们用的是`axum`框架和MySQL数据库。如果要使用`actix-web`框架和PostgreSQL数据库，那就添加以下依赖：
```toml
[dependencies]
actix-web = "4.5.1"
serde = { version = "1.0.197", features = ["derive"] }
tracing = "0.1.40"
zino = { version = "0.18.2", features = ["actix"] }
zino-core = { version = "0.19.2", features = ["orm-postgres"] }
zino-derive = "0.16.2"
zino-model = "0.16.2"
```
进而我们在`src`目录创建`controller`、`model`、`router`三个模块（此时`mod.rs`中都还是空文件），
在`main.rs`中添加以下代码：
```rust
mod controller;
mod model;
mod router;

use zino::prelude::*;

fn main() {
    zino::Cluster::boot().run()
}
```