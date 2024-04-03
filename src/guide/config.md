# 配置文件

Zino框架支持根据运行环境来加载配置，不同环境的配置项定义在`config/config.{env}.toml`文件中。
具体运行环境的选择，按照以下优先顺序来判断：

1. 应用启动时传入的`--env`参数，如`cargo run -- --env=dev`；
2. 如果命令参数不存在，将尝试读取环境变量`ZINO_APP_ENV`（Zino框架也会自动加载项目目录中的`.env`文件）；
3. 假如环境变量也不存在，将根据`cfg!(debug_assertions)`给出默认值：取值为`true`，则运行环境为`dev`，
否则为`prod`。

开发环境`dev`和生产环境`prod`是预定义的两个取值。如有需要，你也可以自行添加其它运行环境，比如`test`环境，
对应的配置文件为`config/config.test.toml`。

当然，除了Rust社区中最常用的TOML格式，我们也支持JSON格式的配置文件，
可通过环境变量`ZINO_APP_CONFIG_FORMAT`进行选择。默认情况下，配置文件是从本地加载的；
如果你需要从远程URL加载，那就请设置环境变量`ZINO_APP_CONFIG_URL`，
此时配置文件格式是通过请求响应的`content_type`来判断的。

鉴于Zino框架的配置项比较多，在项目开发的初始阶段我们推荐你采用默认值，这样可以省略绝大多数的配置项。
如果确有需要，在项目开发的过程中再逐渐添加。

一个最简单的配置文件示例如下：
```toml
name = "DataCube"
version = "1.0"
```
需要注意的是，这里的`name`和`version`是指应用的名称和版本，与`Cargo.toml`里`[package]`的`name`和`version`不是一个概念。

在这里，我们只列出全局配置项，具体功能的配置项将在后面的功能模块里给出。

- `name`：应用名称
  ```toml
  name = "DataCube"
  ```
- `version`: 应用版本
  ```toml
  version = "1.0"
  ```
- `secret`: 应用密文，用于推导`Application`的[`secret_key`][docsrs-secret-key]。
  当缺失时，会根据应用名称和版本自动生成。
  ```toml
  secret = "SecretPhrase"
  ```

[docsrs-secret-key]: https://docs.rs/zino-core/latest/zino_core/application/trait.Application.html#method.secret_key
