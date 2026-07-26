# 構造化テキストの検査: 何を型で落とし、何を実行時に残すか

`structured-latex/` の誤りは、**できる限りコンパイル時（`tsc`）に落とす**方針である。
このメモは「いま何が型で落ちるか」と「型で落とせないものは**なぜ**落とせないか」を、
実際に型を書いて確かめた結果とともに記録する。憶測ではなく、下記はすべて実測に基づく。

対応する実証テスト: `structured-latex/tools/negative-type-test.ts`（誤った入力で `tsc` が実際に
落ちること、および正しい入力では落ちないことを対で確認する。18 ケース）。

## 1. 型で落ちるもの（コンパイル時）

| 検査項目 | 仕組み | 誤ったときの診断 |
|---|---|---|
| `ref()` が存在しないラベルを指す | `ref(target: Label)`。`Label` は content から生成したユニオン型 | 近い綴りの候補付き（TS2820） |
| ノートの `targets` が存在しないラベルを指す | `targets: readonly [Label, ...Label[]]` | 同上 |
| ノートの `targets` が空 | 1 件以上を要求するタプル型 | `Source has 0 element(s) but target requires 1` |
| ブロックが未登録のラベルを宣言 | `labels: readonly Label[]`（＝生成物の再生成漏れを検出） | TS2820 |
| **同一ファイル内**の id 重複 | `defineBlocks` の `const` 型引数＋重複検出型 | `__ブロックidが重複している: "<id>"` |
| **同一ファイル内**のラベル重複 | 同上 | `__ラベルが重複している: "<label>"` |
| **同一ファイル内**のノート id 重複 | `defineNotes` の同種の型 | `__ノートidが重複している: "<id>"` |
| **ファイルを跨いだ** id / ラベル / ノート id の重複 | `document.generated.ts`（全ファイルを import して 1 本のタプルへ連結し、重複を `never` 制約で拒否） | `Type '"<値>"' does not satisfy the constraint 'never'` |
| ノート id とブロック id の衝突 | 同上（両者を連結して重複判定） | 同上 |
| 見出しブロックが本文（`statement` / `proof`）を持つ | `HeadingBlock` の `statement?: never` | TS2322 |
| 定理型ブロックが見出し専用の `level` を持つ | `TheoremLikeBlock` の `level?: never` | TS2322 |
| 見出しの `level` が 1〜6 の範囲外 | `HeadingLevel = 1｜2｜3｜4｜5｜6` | TS2322 |
| タイトルが `text` も `tex` も持たない | `TitleContent` を「少なくとも一方が必須」の union に | TS2322 |
| `conversion.status` の綴り違い | `ConversionStatus = "converted" ｜ "added"` | TS2820（候補付き） |
| フィールド名の打ち間違い（`proof` → `proofs`） | 余剰プロパティ検査 | `Did you mean to write 'proof'?` |
| 本文ブロックが `notes` を持つ | `notes?: never` | TS2322 |
| 生成済みラベル一覧が content とずれている（両方向） | `document.generated.ts` の `Exclude` 主張 | `does not satisfy the constraint 'never'` |
| `sourceOrdinal` が正の整数でない | 数値リテラル型をテンプレートリテラル型で文字列化して判定 | `__sourceOrdinalが正の整数でない: 2.5` |

### 実装上の要点（同じ轍を踏まないために）

- **`const` 型引数だけでは余剰プロパティ検査が効かなくなる。** 実測: `defineBlocks<const T>(b: T)`
  の形にすると `proofs:` の打ち間違いが素通りした。`b: T & readonly ConvertedBlock[]` と
  **具体型との交差**にすると、リテラル型の推論（重複検出に必要）と余剰プロパティ検査が両立する。
- **重複検出の再帰型は末尾再帰で書く。** 素朴な `[...H["labels"], ...LabelsOf<R>]` は 173 ブロック
  規模で TS2589（Type instantiation is excessively deep）になる。このとき `tsc` 自体は落ちる
  （exit 2）が、**診断が TS2589 に化けて「重複がある」という指摘は出なくなる**——つまり
  検査としては役に立たなくなる。累積引数を持つ末尾再帰形にすると通る。
- **再帰の限界は実測で約 900 要素。** 末尾再帰形でも、要素数 1000 で TS2589 になり重複検出が
  止まる（100/200/400/800/900 は検出、1000 以降は不可）。現状の入力は id 173＋ノート id 38＝211、
  ラベル 146 なので約 4 倍の余裕がある。将来これを超えたら、章ごとに分割して部分結果を
  合成する形へ変える（TS2589 が出たら「検査が壊れた」と読むこと）。
- **生成した集約モジュールを `tsconfig.json` の `include` に入れ忘れると、検査は静かに消える。**
  実際に一度この状態になり、負テストを書いて初めて気づいた。いまは二重に塞いである:
  (a) `type-tests/label-typing.test-d.ts` が `document.generated.ts` を型 import しているので、
  include から落ちても検査対象に残る。(b) `tools/generate-index.ts` が
  `tsconfig.json` の include に生成物 2 種が書かれていることを検査する。
- **制約の無い「主張」は何も検査しない。** `export type X = A extends B ? true : never;` は条件が
  偽でも `never` という別名が定義されるだけでエラーにならない（実測）。`Assert<T extends true>`
  のように**制約**の形にして初めて落ちる。

## 2. 型では落とせないもの（実行時検査として残す）

### 2.1 未変換の Typst 記法の混入（`dot.op` / `mat(` / `cases(` など）

**型で書けないのは制約ではなく、入力がリテラル型でないことが原因。**

テンプレートリテラル型で「特定の部分文字列を含む文字列を拒む」制約は書ける。実測:

```ts
type NoTypstToken<S extends string> = S extends `${string}dot.op${string}` ? never : S;
declare function mathChecked<S extends string>(tex: NoTypstToken<S>): { tex: S };

mathChecked("a dot.op b");
// error TS2345: Argument of type '"a dot.op b"' is not assignable to parameter of type 'never'.
```

ところが content の数式はすべて `String.raw` タグ付きテンプレートで書かれており、
**`String.raw` の戻り値型は `string`（リテラル型ではない）** である。実測: 上の
`mathChecked(String.raw\`a dot.op b\`)` は**エラーにならない**。
`String.raw` はバックスラッシュを書くために必須（LaTeX は `\` だらけ）なので、
リテラル型を得るには本文 24,000 行のエスケープを書き換えることになり、割に合わない。

自前のタグ付きテンプレート関数でリテラル型を取れないかも試したが、`TemplateStringsArray` の
`raw` は要素型が `string` に潰れるため、`const` 型引数を付けてもリテラルは得られない（実測）。
**タグ経由でも不可能**である。

→ `tools/validate-content.ts` の正規表現スキャンを実行時検査として維持する。

### 2.2 （解決済み）`sourceOrdinal` が正の整数であること — 型で書けた

当初「TypeScript に整数型・数値範囲型が無いので不可能」と書いていたが、**これは誤りだった**。
整数型は無いが、数値**リテラル型**はテンプレートリテラル型で文字列化して判定できる。

```ts
type PositiveIntegerString<S extends string> = S extends `${string}.${string}`
  ? never
  : S extends `-${string}`
    ? never
    : S extends "0" | "NaN" | "Infinity"
      ? never
      : S;
```

`defineBlocks` は `const` 型引数でリテラルを保持しているので、この判定を重複検出と同じ形で
引数の交差に載せられる。実測: 実データ 173 ブロックはそのまま通り、`sourceOrdinal: 2.5` /
`-3` / `0` はいずれもコンパイル時に落ちる（診断に `__sourceOrdinalが正の整数でない` と当該値が出る）。

→ §1 の表へ移した。`Number.isInteger` の実行時検査は §2.6 の保険として残す。

### 2.3 `sourcePath` が実在すること

型システムはファイルシステムを参照できない。`sourcePath` は Typst 原本
（`_old/typst/...`）へのパスなので、実在確認は `fs.existsSync` でしか行えない。

厳密には「不可能」ではなく**設計判断**である: ラベルと同じく、生成時にディレクトリを走査して
実在パスのユニオン型を吐けば型へ寄せられる。いまそうしていないのは、原本が更新されない
アーカイブであり、生成物を 1 つ増やす価値が薄いと判断したため。

→ `tools/verify-no-lost-proofs.ts` が実在しないパスをエラーにする（黙って skip しない）。

### 2.4 SageMath の数値検証との対応（`sagemath/check/*/overview.md`）

対象ラベルは Markdown の本文中に書かれている。型システムは Markdown を読めない。

→ `sagemath/tools/verify-check-linkage.ts` が実行時に照合する
（照合先は `labels.generated.ts` なので、ラベル側の正しさは型と同じ情報源に揃っている）。

これも §2.3 と同じく、overview.md を生成時に読んでユニオン型を吐けば型へ寄せられる。
Markdown を正本のままにするか、宣言を TypeScript 側へ移すかの設計判断である。

### 2.5 生成物（`labels.generated.ts` / `document.generated.ts`）とファイル一覧の一致

`document.generated.ts` は「列挙されたファイル」の中身については型で保証するが、
**ディレクトリに増えたファイルが列挙から漏れている**ことは型では検出できない
（型システムはディレクトリを列挙できない）。

→ `node tools/generate-index.ts --check` が、生成し直した結果と現物の一致を検査する
（`npm run check` の最初のステップ。CI でも回る）。

### 2.6 型を経由せずに作られた値

`as never` などで型検査を迂回して作った値、実行時に動的生成した値は、当然ながら型では
守られない。実行時検証（`validate-content.ts` と `schema.ts` の検証関数）はこの経路への保険として
残してある。その保険が効いていることは `tools/schema-runtime-test.ts` で確認する。
型へ移した項目（`conversion.status` の値域、タイトルの `text`/`tex` 必須、`sourceOrdinal` の整数性、
id・ラベルの重複）は、実行時検査の側にも同じ基準を残してある。

## 3. 検査の回し方

```sh
cd exact-solution-of-2d-ising-model/structured-latex
pnpm install      # 初回のみ
npm run check     # 生成物の鮮度 → 型検査 → 実行時検証 → 移行漏れ検出 → 負テスト → 実行時検証テスト
```

ラベル・ブロックを増減したら `node tools/generate-index.ts` で生成物を作り直す
（忘れると型検査が落ちるので、取りこぼしにはならない）。
