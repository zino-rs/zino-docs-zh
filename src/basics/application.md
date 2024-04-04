# 应用接口抽象

Zino框架的应用接口抽象由[`Application`] trait定义，它包含一个关联类型和两个必须实现的方法：

```rust
pub trait Application {
    type Routes;

    fn register(self, routes: Self::Routes) -> Self;
    fn run_with<T: AsyncScheduler + Send + 'static>(self, scheduler: T);
}
```
其中[`register`]用来注册路由，[`run_with`]用来加载异步任务并运行应用。
需要注意的是，异步任务的执行涉及到异步运行时的选择，
而[`zino-core`]本身并没有限定只能使用特定的运行时[^runtime]，
所以需要实现者自行在[`run_with`]方法的实现中指定。对于同步任务，不涉及到异步运行时的选择，
我们就在[`Application`]的[`spawn`]方法中提供了默认实现。

这就是Zino框架的起点！我们只要给其他Web框架实现这个trait，就能把这个框架的功能集成到Zino中，并使应用的启动方式保存一致：
```rust
mod router;
mod schedule;

use zino::prelude::*;

fn main() {
    zino::Cluster::boot()
        .register(router::routes())
        .register_debug(router::debug_routes())
        .spawn(schedule::job_scheduler())
        .run_with(schedule::async_job_scheduler())
}
```

目前我们已经为[`actix-web`]、[`axum`]、[`dioxus-desktop`]实现了[`Application`] trait，
它们对应的关联类型[`Routes`]分别为：

- [`actix-web`]：引入`ActixCluster`类型，基于[`ServiceConfig`]来定义路由。

  ```rust
  pub type RouterConfigure = fn(cfg: &mut actix_web::web::ServiceConfig);

  impl Application for ActixCluster {
      type Routes = Vec<RouterConfigure>;
  }
  ```

- [`axum`]：引入`AxumCluster`类型，基于[`Router`]来定义路由。

  ```rust
  impl Application for AxumCluster {
      type Routes = Vec<axum::Router>;
  }
  ```

- [`dioxus-desktop`]：引入`DioxusDesktop<R>`类型，基于[`Routable`]泛型约束来定义路由。

  ```rust
  impl Application for DioxusDesktop<R>
  where
      R: dioxus_router::routable::Routable,
      <R as FromStr>::Err: Display,
  {
      type Routes = R;
  }
  ```

可以看到，在以上框架的[`Application`]实现中，我们并没有定义自己的路由类型，
这就使得[`actix-web`]和[`axum`]中的路由、中间件可以直接在我们的Zino框架中使用。
确保充分理解了这一点，对我们的应用开发至关重要。

[^runtime]: 虽然大部分情况下我们还是会优先选择[`tokio`]。

[`zino-core`]: https://docs.rs/zino-core
[`tokio`]: https://docs.rs/tokio
[`actix-web`]: https://crates.io/crates/actix-web
[`axum`]: https://crates.io/crates/axum
[`dioxus-desktop`]: https://crates.io/crates/dioxus-desktop
[`dioxus-router`]: https://crates.io/crates/dioxus-router
[`Application`]: https://docs.rs/zino-core/latest/zino_core/application/trait.Application.html
[`Routes`]: https://docs.rs/zino-core/latest/zino_core/application/trait.Application.html#associatedtype.Routes
[`register`]: https://docs.rs/zino-core/latest/zino_core/application/trait.Application.html#tymethod.register
[`run_with`]: https://docs.rs/zino-core/latest/zino_core/application/trait.Application.html#tymethod.run_with
[`spawn`]: https://docs.rs/zino-core/latest/zino_core/application/trait.Application.html#method.spawn
[`ServiceConfig`]: https://docs.rs/actix-web/latest/actix_web/web/struct.ServiceConfig.html
[`Router`]: https://docs.rs/axum/latest/axum/struct.Router.html
[`Routable`]: https://docs.rs/dioxus-router/latest/dioxus_router/routable/trait.Routable.html
