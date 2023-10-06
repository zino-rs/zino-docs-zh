# 入门指南

## 快速开始

你可以通过[`actix-app`]、[`axum-app`]或者[`dioxus-desktop`]快速开始体验zino框架。
当前我们需要使用**nightly**来构建项目。

```shell
git clone https://github.com/photino/zino.git
cd zino/examples/axum-app
cargo run -- --env=dev
```

## 注意事项

目前暂时没有构建工具，新建项目推荐大家下载使用**examples**中的例子修改依赖来使用，
选择自己想要使用的**examples**删除其中**Cargo.toml**中的路径依赖就可以愉快的使用了。

[`actix-app`]: https://github.com/photino/zino/tree/main/examples/actix-app
[`axum-app`]: https://github.com/photino/zino/tree/main/examples/axum-app
[`dioxus-desktop`]: https://github.com/photino/zino/tree/main/examples/dioxus-desktop
