# notes-contracts

6A Demo 项目 · API 契约共享库(OpenAPI 3.1 + TypeScript types)。

## 目的

定义 `notes-mobile`(消费方)和 `notes-backend`(实现方)之间的 API 契约。契约变更由**架构经理 Agent 统一把关**,两侧 repo 通过 git submodule 引用,版本锁明确。

## 目录结构

```
openapi/
└── notes-api.yaml          # OpenAPI 3.1 源文件
scripts/
└── generate-types.sh       # 从 yaml 生成 TS types
dist/                       # 生成物(gitignore)
└── notes-api.d.ts          # CI 产出,Release 时发布
```

## 本地生成 TS types

```bash
npm install
npm run build           # validate + generate
# 或
./scripts/generate-types.sh
```

产出 `dist/notes-api.d.ts`,供 mobile / backend 引用。

## 被引用方式(git submodule)

在 `notes-mobile` / `notes-backend` 根目录:

```bash
git submodule add git@github.com:wgj-code/notes-contracts.git contracts
git submodule update --init --recursive
```

之后 TS import:

```ts
import type { components } from './contracts/dist/notes-api';
type Note = components['schemas']['Note'];
```

## 变更流程

1. 开发者提 PR 修改 `openapi/notes-api.yaml`
2. CI 自动跑 `redocly lint` + types 生成,失败不让合
3. 架构经理 review + 批准(CODEOWNERS 守卫)
4. merge 后,下游 repo(mobile / backend)按需 bump submodule 版本

## 关联文档

- [A1 基础设施实例化 Checklist](https://www.feishu.cn/wiki/ZHlhwUPK7i8oDBkCem4cvb4FnUc)
- [6A 压测报告 v0.1](https://www.feishu.cn/wiki/ZBptwnRdfiVDdzk3164ckmyHn3o)
