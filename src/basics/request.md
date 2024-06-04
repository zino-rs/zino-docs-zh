# 请求上下文

与[`actix-web`]、[`axum`]、[`ntex`]等框架不同，我们并不推荐使用提取器（Extractor）模式[^extractor]，
而是采取类似于[`Express`]和[`Fiber`]那种把很多方法都挂在请求上下文的做法，这会带来几个好处：

1. 保持`controller`中只有`Request`一个参数，便于批量实现接口以及代码自动生成；
2. 允许使用者动态判断是否需要从请求中获取信息，避免使用不必要的`Option`类型；
3. 能够提供非异步的实现，比如从URI中提取查询参数这种本来就应该是同步的[^axum-query]。

当然，由于我们提供了对[`actix-web`]、[`axum`]、[`ntex`]等框架的集成，它们所支持的Handler都是可以直接在Zino中使用的，
也包括提取器模式。

我们通过[`RequestContext`]这一trait来提供请求上下文方法，它包含以下必须要实现的方法：

```rust
pub trait RequestContext {
    type Method: AsRef<str>;
    type Headers;

    fn request_method(&self) -> &Self::Method;

    fn original_uri(&self) -> &Uri;
    fn matched_route(&self) -> Cow<'_, str>;

    fn header_map(&self) -> &Self::Headers;
    fn get_header(&self, name: &str) -> Option<&str>;
    fn client_ip(&self) -> Option<IpAddr>;

    fn get_context(&self) -> Option<Context>;

    fn get_data<T: Clone + Send + Sync + 'static>(&self) -> Option<T>;
    fn set_data<T: Clone + Send + Sync + 'static>(
        &mut self,
        value: T
    ) -> Option<T>;

    async fn read_body_bytes(&mut self) -> Result<Vec<u8>, Error>;
}
```
值得注意的是，我们提供的`read_body_bytes`方法不会消费`Request`对象[^axum-body]，但是它的重复调用并不保证会给出相同的结果，
具体处理方式由实现决定。

[^extractor]: 有些人总觉得Rust中的提取器很神奇，其实无外乎就是泛型加上宏批量实现罢了，Rust本身并不支持可变参数函数。
[^axum-query]: `axum`的`Query`提取器尽管提供了同步的[`try_from_uri`]方法，但它实现的[`from_request_parts`]却是异步的。
[^axum-body]: 在`axum`中，实现了[`FromRequest`]的提取器总会消费`Request`对象，所以它们只能使用一次，并且只能作为`Handler`的最后一个参数。

[`actix-web`]: https://crates.io/crates/actix-web
[`axum`]: https://crates.io/crates/axum
[`ntex`]: https://crates.io/crates/ntex
[`Express`]: https://expressjs.com/en/5x/api.html#req
[`Fiber`]: https://docs.gofiber.io/api/ctx
[`RequestContext`]: https://docs.rs/zino-core/latest/zino_core/request/trait.RequestContext.html
[`try_from_uri`]: https://docs.rs/axum/latest/axum/extract/struct.Query.html#method.try_from_uri
[`from_request_parts`]: https://docs.rs/axum/latest/axum/extract/trait.FromRequestParts.html#tymethod.from_request_parts
[`FromRequest`]: https://docs.rs/axum/latest/axum/extract/trait.FromRequest.html
