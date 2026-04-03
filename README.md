# Flutter GraphQL（`graphql` 官方客户端）

## 简介

用 **`graphql`** 包构造 `GraphQLClient`，`HttpLink` 指向公开 Countries API，`QueryOptions` 携带变量查询 `country(code: "JP")`，把 `data` 或异常打印到界面。

## 快速开始

### 环境要求

Flutter SDK；网络可达 `https://countries.trevorblades.com/graphql`。

### 运行

```bash
flutter pub get
flutter run
```

## 概念讲解

### 第一部分：Client、Link 与 Cache

`GraphQLClient(link: ..., cache: GraphQLCache())` 是入口。Demo 用最简内存缓存；复杂应用可换持久缓存或规范化缓存策略。

### 第二部分：gql 与变量

查询字符串用 `gql(...)` 包成 `DocumentNode`，变量放在 `variables` Map 里，类型要与服务端 schema 一致（此处 `code` 为 `ID!`）。

## 完整示例

`lib/main.dart` 中 `_GraphqlPageState` 的 `initState` 建 client、`_load` 里 `query`。

## 注意事项

- 生产环境可拆「schema 代码生成」、错误边界、认证 Header（在 `HttpLink` 外包 `AuthLink` 等）。
- Web 与部分宿主对 CORS 有要求；若自建网关需配置跨域。

## 完整讲解（中文）

GraphQL 和 REST 的差别，在客户端主要体现在：**你写的是「我要的字段树」而不是「固定一个 REST 路径」**。本 Demo 故意做成「一页显示原始 data」，让你先确认链路：请求发出、JSON 回来、异常能显示。等熟悉以后，再把 `QueryOptions`、`MutationOptions`、分页、订阅拆到 Repository，和 Flutter 界面解耦即可。
