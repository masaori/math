# トーラスの Kac--Ward データを定義する

## 概要

有限正方格子トーラス上の向き付き辺、辺の反転、非後退遷移、回転半角位相、二方向の巻き付き符号、四つのねじれ Kac--Ward 行列を具体的に定義する。

## 背景・前提

- 既存ラベル `def_periodic_lattice`, `def_high_temperature_even_subgraph`, `def_winding_parities` を確認して再利用する。
- Cimasoni, *A generalized Kac--Ward formula*, arXiv:1004.3158 のトーラスの場合を正本とする。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

定義と well-defined 性だけを扱う。行列式公式と Fourier 分解は後続タスクへ分ける。抽象グラフ一般には持ち上げない。

## 記号の帰属と ℝ 脱出の見込み

- 頂点・向き付き辺・スピン構造は有限集合、巻き付き符号は `{-1,1}`、辺重みは `QQ[x]` に住む。
- 回転半角位相は正方格子で現れる有限個の値を `QQ(ζ₈)` に具体化する。解析的な偏角や `exp` を定義に使わない。
- 実数への脱出はない。

## 作業内容

### 有限データの定義

- 向き付き辺と反転写像を座標で定義し、反転が固定点を持たない対合であることを示す。
- U ターンを除く連接関係と、直進・左右折の三場合に対する位相を `ζ₈` の冪で定義する。
- 水平・垂直の基本切断を横切る回数の偶奇から四つのねじれを定義する。
- 各ねじれについて `4L² × 4L²` Kac--Ward 遷移行列と恒等行列との差を定義する。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`（新規の内容依存ラベルを付ける）

## 完了条件

- [ ] 全写像の定義域・終域と全行列の係数環・寸法が明示され、well-defined 性が証明されている。
- [ ] 偏角・実指数を使わず `QQ(ζ₈)` 上の有限表として定義されている。
- [ ] 一ステップ一定理、参照解決、住処宣言を満たす。
- [ ] `npm run gen`, `npm run check`, `validate-content.ts`, `verify-no-lost-proofs.ts`, `verify-check-linkage.ts`, PDF build が通る。
- [ ] SageMath と Lean は各後続タスクで行うことが本文と台帳に明記されている。
