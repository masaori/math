# ユーザーファーストなエラーハンドリング戦略

## 根本思想

エラーとは「ユーザーの操作に影響がある事象」である。影響がないならそれはエラーではない。

したがって：

- **伝える必要のないエラーは存在しない** — エラーが起きたなら、ユーザーに伝える
- **サイレントキャッチは禁止** — `console.error` で終わるハンドリングは問題の先送りであり、禁止する
- **fire-and-forget の失敗も同様** — cleanup 等の失敗がユーザーに影響するなら伝える。影響しないなら、その処理自体の設計を見直す

---

## 原則

### 1. Result型で伝搬する

全ての想定内エラーは Result 型（Discriminated Union）で表現し、呼び出し元に処理を強制する。

```typescript
type Result<T, E> = { success: true; data: T } | { success: false; error: E }
```

throw による伝搬は使わない。Result 型により、エラーの存在が型システム上で可視化され、処理漏れがコンパイル時に検出される。

### 2. try/catch は外界との境界のみ

try/catch が許容される場所は **外界との境界** に限定する。

- HTTPリクエスト受信（Handler）
- 外部サービス呼び出し（Repository / Adapter）
- ブラウザAPI（fetch, localStorage 等）

これらの境界で外部のエラーを捕捉し、Result 型に変換する。それ以外の層で try/catch が必要になる状況は、型の運用に誤りがあることを意味する。修正すべきは catch ではなく型定義である。

### 3. api-contract がエラーの共通語彙

BE と FE の間のエラー表現は api-contract で網羅的に定義する。

- **BE の責務**: エラーを分類し、contract で定義された code を返す
- **FE の責務**: code からユーザー向けメッセージに変換する
- **api-contract の責務**: 各 operation ごとのエラー code を discriminated union として定義する

```typescript
// api-contract: operation ごとにエラーを網羅定義
type CreateResourceError =
  | { code: 'validation_error'; fields: Record<string, string> }
  | { code: 'already_exists' }
  | { code: 'internal_error' }

// FE: 型で全 code への対応を強制
const messages: Record<CreateResourceError['code'], string> = {
  validation_error: '入力内容を確認してください',
  already_exists: 'すでに登録されています',
  internal_error: '問題が発生しました。時間をおいて再度お試しください',
}
```

### 4. internal_error は設計漏れ

`internal_error` は全 operation に必ず存在する。しかし、これが実際に返される状況は **contract の設計漏れ** を意味する。

- 発生したら contract を拡充し、適切な error code を追加する
- `internal_error` の発生頻度は、contract の成熟度の逆指標である

### 5. データバリデーションは Zod

ランタイムバリデーションには Zod の `safeParse` を使用し、結果を Result 型に変換する。`.parse()`（throw する方）は使わない。

---

## 各レイヤーの責務

### Backend

```
外部サービス → Repository/Adapter → UseCase → Handler → Response
                ここで try/catch      Result で伝搬   contract の code を返す
                → Result に変換
```

- **Repository / Adapter**: 外部サービスのエラーを try/catch で捕捉し、Result 型に変換する。ドメイン層にインフラのエラー型を漏らさない
- **UseCase**: Result 型を受け取り、ビジネスロジックに基づいてエラーを判定・伝搬する。try/catch は書かない
- **Handler**: UseCase の Result を api-contract 準拠のレスポンスに変換する

### Frontend

```
Backend Response → api-crud/api-stream → entities hooks → page fetch → Page Component
                   Result に変換          Result で伝搬    onError を     UI に表示
                                                          必ず処理する
```

- **api-crud / api-stream（frontend/_shared）**: レスポンスを Result 型に変換する。外界との境界としての try/catch はここ
- **entities hooks**: Result 型をそのまま伝搬する
- **page fetch**: TanStack Query の `onError` を **必ず** ハンドルする。I/F として error state を page に公開する
- **Page Component**: error state を受け取り、ユーザーに表示する

---

## 禁止事項

| 禁止 | 理由 |
|------|------|
| `.catch(() => {})` / `.catch(console.error)` | エラー情報の消失。問題の先送り |
| 外界境界以外での try/catch | 型の運用ミスの隠蔽 |
| `.parse()`（Zod） | throw するため。`.safeParse()` を使う |
| onError ハンドラの省略（TanStack Query mutation） | ユーザーへのフィードバック漏れ |
| api-contract に定義されていない error code の返却 | 共通語彙の破壊 |
