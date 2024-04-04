# 错误处理

在Zino框架中，我们定义了一个通用的错误类型[`Error`]，主要目的是实现以下功能：

1. 基于字符串将任意错误包装成同一类型；
2. 支持错误溯源，并能追溯到原始错误；
3. 支持[`tracing`]，自动记录错误信息。

这三条需求对Zino框架至关重要，这也是为什么我们没有采用社区中流行的错误处理库，比如[`anyhow`]。
在实际应用开发中，我们往往并不会对具体的错误类型做不同的处理[^new_error]，而是直接返回错误消息，
所以我们采取基于字符串的错误处理：
```rust
#[derive(Debug)]
pub struct Error {
    message: SharedString,
    source: Option<Box<Error>>,
}
```
其中[`SharedString`]是Zino中用来优化静态字符串处理的类型[^benchmark]。
我们可以调用[`sources`]方法返回一个迭代器进行错误溯源，也可以使用[`root_source`]方法来追溯到原始错误。

对于任意实现了[`std::error::Error`] trait的错误类型，我们可以将它转换为[`Error`]类型：
```rust
impl<E: std::error::Error> From<E> for Error {
    #[inline]
    fn from(err: E) -> Self {
        Self {
            message: err.to_string().into(),
            source: err.source().map(|err| Box::new(Self::new(err.to_string()))),
        }
    }
}
```
这样在需要返回`Result<T, zino_core::error::Error>`的函数中，我们就可以很方便地使用`?`运算符。
需要注意的是，我们的[`Error`]类型本身并没有实现[`std::error::Error`]。

通过为[`Error`]类型实现[`std::fmt::Display`]，我们可以提供对[`tracing`]的集成，让它自动记录错误信息：
```rust
impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let message = self.message();
        if let Some(source) = &self.source {
            let source = source.message();
            let root_source = self.root_source().map(|err| err.message());
            if root_source != Some(source) {
                tracing::error!(root_source, source, message);
            } else {
                tracing::error!(root_source, message);
            }
        } else {
            tracing::error!(message);
        }
        write!(f, "{message}")
    }
}
```
每当我们调用`.to_string()`时，`tracing::error!`就会自动生成一条记录。

[^new_error]: 当然，你也可以自定义可枚举的错误类型，并为其实现[`std::error::Error`] trait。
[^benchmark]: 我们的[`Error`]类型对于静态字符串的处理有巨大的性能优势，具体可以参考我们的[`box_error`]测试。

[`anyhow`]: https://docs.rs/anyhow
[`tracing`]: https://docs.rs/tracing
[`Error`]: https://docs.rs/zino-core/latest/zino_core/error/struct.Error.html
[`SharedString`]: https://docs.rs/zino-core/latest/zino_core/type.SharedString.html
[`sources`]: https://docs.rs/zino-core/latest/zino_core/error/struct.Error.html#method.sources
[`root_source`]: https://docs.rs/zino-core/latest/zino_core/error/struct.Error.html#method.root_source
[`box_error`]: https://github.com/zino-rs/zino/blob/main/zino-core/benches/box_error.rs
[`std::error::Error`]: https://doc.rust-lang.org/nightly/std/error/trait.Error.html
[`std::fmt::Display`]: https://doc.rust-lang.org/nightly/std/fmt/trait.Display.html