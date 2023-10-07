# 配置文件

```toml

# --env=prod 此处标志文件所属环境 env 或者prod

name = "data-cube" # 应用名称可自行设定
version = "0.6.3" # 当前应用版本号

[dirs]
uploads = "local/uploads"

[main]
host = "127.0.0.1" # 应用地址
port = 6080 # 应用端口

[[standby]]
host = "127.0.0.1" # 应用2地址
port = 6081 # 应用2端口

[[standby]]
host = "127.0.0.1" # 应用3地址
port = 6082 # 应用3地址

[server] # 静态页面映射配置
page-dir = "public"

[database]
type = "mysql" # 选择使用的数据库
namespace = "dc" # 命名空间

[[mysql]] # 数据库配置
host = "127.0.0.1"
port = 3306
database = "data_cube"
username = "root"
password = "WoWhU03uWHCDGXdY/v49Q9XP/xTe/2ydXG6oh4QiVxY"

[[postgres]] # 数据库配置
host = "127.0.0.1"
port = 5432
database = "data_cube"
username = "postgres"
password = "xy6IsBbwqK0FzrxdRvrxi0F+NC1YqlnQRUj78aqxrV576D2b"

[[sqlite]] # 数据库配置
database = "local/data/main.db"

[tracing] # 追踪级别
filter = "warn"

[metrics] # 监控地址
exporter = "prometheus"
host = "127.0.0.1"
port = 9000

[jwt] # jwt配置
max-age = "20m"
refresh-interval = "7d"

[[connector]] # 模拟数据
type = "arrow"
name = "mock"
root = "./assets/data/mock/"

[[connector.tables]] # 模拟数据
type = "csv"
name = "users"
path = "./users.csv"

[[connector.tables]] # 模拟数据
type = "ndjson"
name = "logs"
url = "http://localhost:6080/public/data/logs.ndjson"

[connector.tables.schema]
timestamp = "string"
level = "string"
fields = { message = "string" }
target = "string"
span = { "http.method" = "string", "http.target" = "string", "http.status_code" = "int" }

[connector.variables]
app-name = "data-cube"
```

通过调用不同配置文件切换开发环境

```bash
# 注意使用ZINO_APP_ENV 也可以获取环境变量
# 其中环境变量--env 优先于ZINO_APP_ENV，最后才会读取默认值dev
  
cargo run -- --env=dev # 开发环境
cargo run -- --env=prod # 生产环境
```
