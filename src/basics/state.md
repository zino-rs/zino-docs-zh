# 状态管理

在Zino框架中，应用状态是由[`State`]类型提供的：
```rust
#[derive(Debug, Clone)]
pub struct State<T = ()> {
    env: Env,
    config: Table,
    data: T,
}
```
它包含有运行环境[`Env`]、TOML格式的配置文件[`Table`]以及自定义数据类型`T`。

不同于很多Web框架，我们的应用状态管理是基于惰性初始化的全局变量来实现的，主要考量如下：

1. 应用状态通常存在于整个运行期间，也就是说它的生命周期为`'static`；
2. 应用状态通常只需要初始化加载一次，并且在运行期间并不会被修改；
3. 尽可能避免在`controller`或`service`方法中传递应用状态参数。

回到具体实现上，最核心的几行代码就是
```rust
static SHARED_STATE: LazyLock<State> = LazyLock::new(|| {
    let mut state = State::default();
    state.load_config();
    state
});
```
这定义了一个全局共享的静态变量，通过[`State::shared`]方法可以得到它的一个`&'static`引用，
然后就可以在整个应用中到处使用。

## 示例：如何使用Redis？

```toml
# config/config.dev.toml

[redis]
host = "127.0.0.1"
port = 6379
database = "dbnum"
username = "some_user"
password = "hsfU4Y3aRbxVNuLpVG5T+wb9jIDdQyaUIiPgeQrP0ZRM1g"
```

```rust
//! src/extension/redis.rs

use parking_lot::Mutex;
use redis::{Client, Connection, RedisResult};
use zino_core::{state::State, LazyLock};

#[derive(Debug, Clone, Copy)]
pub struct Redis;

impl Redis {
    #[inline]
    pub fn get_value(key: &str) -> RedisResult<String> {
        REDIS_CONNECTION.lock().get(key)
    }

    #[inline]
    pub fn set_value(key: &str, value: &str, seconds: u64) -> RedisResult<()> {
        REDIS_CONNECTION.lock().set_ex(key, value, seconds)
    }
}

static REDIS_CLIENT: LazyLock<Client> = LazyLock::new(|| {
    let config = State::shared()
        .get_config("redis")
        .expect("the `redis` field should be a table");
    let database = config
        .get_str("database")
        .expect("the `database` field should be a str");
    let authority = State::format_authority(config, Some(6379));
    let url = format!("redis://{authority}/{database}");
    Client::open(url)
        .expect("fail to create a connector to the redis server")
});

static REDIS_CONNECTION: LazyLock<Mutex<Connection>> = LazyLock::new(|| {
    let connection = REDIS_CLIENT.get_connection()
        .expect("fail to establish a connection to the redis server");
    Mutex::new(connection)
});
```
这是Zino框架中推荐的使用模式：在配置文件里编写Redis连接信息[^password]，通过Lazy的全局变量初始化Client；
然后定义一个空结构体，进而封装一些自定义方法。仔细想想，这不就类似于其他语言中的“单例模式”吗？

[^password]: 配置项中的密码也可以先写为明文，运行后会在终端里提醒你修改为加密后的。

[`State`]: https://docs.rs/zino-core/latest/zino_core/state/struct.State.html
[`Env`]: https://docs.rs/zino-core/latest/zino_core/state/enum.Env.html
[`Table`]: https://docs.rs/toml/latest/toml/type.Table.html
[`State::shared`]: https://docs.rs/zino-core/latest/zino_core/state/struct.State.html#method.shared
