# 構造化テキストの検査: このプロジェクト固有の事情

**入力言語（ブロック・ノード・ラベル・ノートの語彙）の検査については、
リポジトリ直下の [`structured-latex/docs/type-coverage.md`](../../structured-latex/docs/type-coverage.md)
が正本である。** 何が型で落ち、何が実行時に残るか、その根拠（`const` 型引数と余剰プロパティ検査、
末尾再帰と TS2589、集約モジュールの include 漏れ）はすべてそちらに集約した。

このメモに残すのは、**このプロジェクトでしか成立しない事情**だけである。

---

## 1. このプロジェクト固有の型検査

`structured-latex/schema.ts` はシステムのファクトリを 2 つの値で具体化する:

- `Label` — `content/` から生成した実在ラベルのユニオン型
- `ConversionMeta` — `conversion: { status: "converted" | "added"; notes?: string[] }`

したがって、システム側の検査に加えて次がコンパイル時に落ちる。

| 検査項目 | 仕組み | 診断 |
|---|---|---|
| `ref()` / `targets` / `labels` が**このプロジェクトに実在しない**ラベルを指す | 生成した `Label` で具体化した `L` | TS2820（近い綴りの候補付き） |
| `conversion.status` の綴り違い | `ConversionStatus = "converted" ｜ "added"` | TS2820（候補付き） |
| `conversion.notes` に文字列を直接書く | `notes?: string[]` | TS2322 |
| `conversion` の中のフィールド名の打ち間違い（`notes` → `note`） | 余剰プロパティ検査 | TS2345 |
| **見出しブロックに `conversion` を書く** | システムの `HeadingBlock` はメタデータ `M` を受け取らない | TS2345 |

実証は `structured-latex/tools/negative-type-test.ts`（7 ケース × 正/誤）。
入力言語そのものの負テストはシステム側が持つので、こちらには重複させていない。

### 見出しが `conversion` を持てないこと（移行時の判断）

システムはメタデータ `M` を**定理型ブロックにだけ**効かせる（`HeadingBlock` は `M` を取らない）。
移行前、このプロジェクトの見出し 22 件はすべて `conversion: { status }` を持っていた。

落としてよいかを実データで確かめた結果、**22 件すべてで `status` は `origin.path` から一意に
決まっていた**（`_old/` 配下なら `converted`、そうでなければ `added`。不一致 0 件）。
また `conversion.notes` を持つ見出しは 0 件だった。したがって落としても情報は失われない。
この確認は `structured-latex/tools/codemod-source-to-origin.ts` が機械的に行い、
1 件でも破れていたら変換を中止する（人手の目視に頼らない）。

---

## 2. 型では落とせないもの（このプロジェクトの実行時検査）

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

→ `structured-latex/tools/validate-content.ts` の正規表現スキャンを実行時検査として維持する。

### 2.2 抽象テンソル積 `\otimes` の混入

README 2 節の要求（テンソル積は具体的なクロネッカー積として書く）は、§2.1 と同じ理由で
型に載せられない。本文全章をクロネッカー積へ置換した後、**後から書かれた章で `\otimes` が
揺り戻る事故**が実際に起きた（011 章・013 章に 4 箇所）。

→ `validate-content.ts` が `content/` のみを対象に検査する
（`notes/` は「採用しなかった経路」を残す場所なので検査しない）。

### 2.3 `origin.path` が実在すること

型システムはファイルシステムを参照できない。`origin.path` は Typst 原本
（`_old/typst/...`）へのパスなので、実在確認は `fs.existsSync` でしか行えない。

厳密には「不可能」ではなく**設計判断**である: ラベルと同じく、生成時にディレクトリを走査して
実在パスのユニオン型を吐けば型へ寄せられる。いまそうしていないのは、原本が更新されない
アーカイブであり、生成物を 1 つ増やす価値が薄いと判断したため。

→ `tools/verify-no-lost-proofs.ts` が実在しないパスをエラーにする（黙って skip しない）。

### 2.4 （移行で型検査から実行時検査へ戻った）`origin.ordinal` が正の整数であること

移行前、このプロジェクトは `sourceOrdinal` の正の整数性を**型で**落としていた
（数値リテラル型をテンプレートリテラル型で文字列化して判定し、`defineBlocks` の引数の交差に
載せる。実測で `2.5` / `-3` / `0` はコンパイル時に落ちていた）。

システムの `Origin` は `ordinal: number` であり、この制約を持たない。制約を取り戻すには
`defineBlocks` の**引数の型を書き直す**必要があり、それは「入力言語の定義をプロジェクト側へ
複製しない」という移行の目的そのものに反する。したがって型検査としては手放した。

→ 実行時検査は残っている（システムの `createRuntimeSchema` が `.int().positive()` で見る。
`tools/schema-runtime-test.ts` がその 1 ケースを持つ）。
**型へ戻すならシステム側に置くのが正しい**（このプロジェクト固有の要求ではないため）。

### 2.5 SageMath の数値検証との対応（`sagemath/check/*/overview.md`）

対象ラベルは Markdown の本文中に書かれている。型システムは Markdown を読めない。

→ `sagemath/tools/verify-check-linkage.ts` が実行時に照合する
（照合先は `labels.generated.ts` なので、ラベル側の正しさは型と同じ情報源に揃っている）。

これも §2.3 と同じく、overview.md を生成時に読んでユニオン型を吐けば型へ寄せられる。
Markdown を正本のままにするか、宣言を TypeScript 側へ移すかの設計判断である。

### 2.6 出力器が未対応の語彙（`figure` ブロック / `image` ノード）

入力言語の語彙にはあるが、`tools/build-latex.ts` は資産解決器も図表の組版規則も持たない。
**このプロジェクトの content には 1 件も無い**が、素通しすると後から書いたときに出力から
無音で消える。

→ 出力器が `figure` / `image` に出会ったら**明示的にエラーにする**（網羅性の穴を黙って作らない）。

---

## 3. 検査の回し方

```sh
cd exact-solution-of-2d-ising-model/structured-latex
pnpm install      # 初回のみ
npm run check     # 生成物の鮮度 → 型検査 → 実行時検証 → 移行漏れ検出 → 負テスト → 実行時検証テスト
```

ラベル・ブロックを増減したら `npm run gen`（＝システムの生成器
`node ../../structured-latex/codegen/structured-text-index/cli.ts --project .`）で
生成物を作り直す（忘れると型検査が落ちるので、取りこぼしにはならない）。
