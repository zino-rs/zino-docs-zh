# 基础模块

Zino框架的主要功能都由[`zino-core`]提供，这是与具体Web框架（如[`actix-web`]或[`axum`]）无关的抽象，
其中最基础的就是以下七大模块：

- [`application`]：应用接口抽象，这是与其它框架差异最大的地方；
- [`state`]：应用状态管理，大量使用Lazy初始化的全局变量；
- [`error`]：通用的错误处理，搭配[`bail!`]、[`warn!`]、[`reject!`]使用；
- [`request`]：请求上下文，通过[`RequestContext`] trait提供方法；
- [`response`]：构建请求响应，统一处理不同的`content-type`；
- [`schedule`]：任务调度，提供[`Scheduler`]、[`AsyncScheduler`]抽象；
- [`model`]：领域模型抽象，与具体的数据库和ORM无关。

[`zino-core`]: https://docs.rs/zino-core
[`actix-web`]: https://docs.rs/actix-web
[`axum`]: https://docs.rs/axum
[`application`]: https://docs.rs/zino-core/latest/zino_core/application/index.html
[`state`]: https://docs.rs/zino-core/latest/zino_core/state/index.html
[`error`]: https://docs.rs/zino-core/latest/zino_core/error/index.html
[`request`]: https://docs.rs/zino-core/latest/zino_core/request/index.html
[`response`]: https://docs.rs/zino-core/latest/zino_core/response/index.html
[`schedule`]: https://docs.rs/zino-core/latest/zino_core/schedule/index.html
[`model`]: https://docs.rs/zino-core/latest/zino_core/model/index.html
[`bail!`]: https://docs.rs/zino-core/latest/zino_core/macro.bail.html
[`warn!`]: https://docs.rs/zino-core/latest/zino_core/macro.warn.html
[`reject!`]: https://docs.rs/zino-core/latest/zino_core/macro.reject.html
[`RequestContext`]: https://docs.rs/zino-core/latest/zino_core/request/trait.RequestContext.html
[`Scheduler`]: https://docs.rs/zino-core/latest/zino_core/schedule/trait.Scheduler.html
[`AsyncScheduler`]: https://docs.rs/zino-core/latest/zino_core/schedule/trait.AsyncScheduler.html
