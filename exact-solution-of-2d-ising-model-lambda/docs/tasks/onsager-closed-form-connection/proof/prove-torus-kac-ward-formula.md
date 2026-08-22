# 四つの Kac--Ward 行列式による有限トーラス公式を証明する

## 概要

高温偶部分グラフ母関数を、四つのスピン構造に対応する Kac--Ward 行列式の定数項 `1` の平方根の符号付き和として表す。

## 背景・前提

- `claim_high_temperature_polynomial_identity`, `claim_high_temperature_sector_decomposition` と Kac--Ward データ定義に依存する。
- トーラスで単一の平方根に置き換えない。Cimasoni arXiv:1004.3158 の genus one の公式を正本とする。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

有限トーラスの多項式恒等式だけを証明する。Fourier 分解と極限は扱わない。

## 記号の帰属と ℝ 脱出の見込み

- 偶部分グラフ母関数は `ZZ[x]`、各行列式とその形式的平方根は `QQ(ζ₈)[x]` に住む。
- 平方根は解析的分岐でなく、定数項が `1` の有限次数形式冪級数の一意な根として構成し、最終的に多項式であることを示す。
- 実数への脱出はない。

## 作業内容

### 歩道展開と符号

- 行列式の置換展開を非後退閉歩道族へ写し、回転位相と自己交差符号を一操作ずつ追跡する。
- 各スピン構造の二次形式が巻き付きセクターへ与える符号を表にせず式で定義し、四つの Arf 符号付き和が各偶部分グラフを係数 `1` で数えることを示す。
- `2^{L²} Z_L(x)=H_L(x)` と接続して分配多項式の有限公式を得る。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`

## 完了条件

- [ ] 四つの平方根の符号付き和が全巻き付きセクターを正しい係数で数えることが証明されている。
- [ ] 単一行列式で済む平面公式との混同がない。
- [ ] 一ステップ一定理、参照解決、住処宣言を満たす。
- [ ] `npm run gen`, `npm run check`, `validate-content.ts`, `verify-no-lost-proofs.ts`, `verify-check-linkage.ts`, PDF build が通る。
- [ ] SageMath と二本の Lean 検証は別タスクであることを明記する。
