# Fisher 零点逆数族の基本対称式と係数比

## 概要

一般有限グラフの重複度込み Fisher 零点の逆数族について、任意次数の基本対称式を Ising
分配多項式の対応する低次係数と定数項の比で表す。

## 背景・前提

- リポジトリ直下の `CLAUDE.md`、`AGENTS.md`、`docs/context/` と、このプロジェクトの `README.md` を読む。
- 依存する本文ラベルは `theorem_fisher_zeros_nonzero`、
  `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`、
  `theorem_partition_polynomial_degree_maximum_broken_edge_count`、
  `claim_partition_polynomial_coefficient_expansion` である。
- 既存の Fisher 零点逆数和の係数比表示を、逆数族の任意次数の基本対称式へ拡張する。

## スコープ

構造化本文へ一つの定理だけを追加し、その式変形を一行ずつ SageMath の厳密演算で検算する。
全辺二分割、複素平面上の配置、熱力学極限は扱わない。

## 記号の帰属と ℝ 脱出の見込み

- グラフ、零点添字集合、その部分集合は有限集合に属する。
- 次数、係数の多重度、部分集合の元数は `N` に属する。
- Ising 分配多項式は `Z[x]`、係数比は `Q`、Fisher 零点、その逆数、基本対称式は `Qbar` に属する。
- 複素平面への埋め込み、数値近似、実数、極限、積分を使わないため、`R/C` 脱出は起きない。

## 作業内容

### 構造化本文

- 次数を `d`、重複度込み Fisher 零点を `alpha_1,...,alpha_d` と置く。
- 任意の `k in {0,...,d}` について、`k` 個の逆数積の総和を
  `(-1)^k Omega_G(k)/Omega_G(0)` と同定する。
- 添字部分集合の補集合写像で逆数積を元の零点の `d-k` 次基本対称式と全零点積の比へ移し、
  既存の基本対称式定理を二度適用する。

### SageMath 検算

- 非零零点について、逆数選択積と補集合選択積を全零点積で結ぶ等式を検算する。
- 逆数族の基本対称式が元の零点族の相補次数の基本対称式と全零点積の比に一致することを検算する。
- 任意次数の逆数基本対称式が符号付き低次係数比に一致することを、次数零を含む有限グラフ例で検算する。

## 対象ファイル

- `structured-latex/content/main-text.ts`
- `sagemath/check/reciprocal-fisher-zero-elementary-symmetric-coefficient-ratio/`

## 完了条件

- [x] 一つの定理として、逆数族の任意次数の基本対称式と低次係数比が証明されている。
- [x] ステートメントと証明が整合している。
- [x] 参照が全て解決し、未解決参照がゼロである。
- [x] 記号の帰属を書き、`R/C` 脱出が無いことを明記した。
- [x] 変更した全 SageMath 検算が `PASS` する。
- [x] 構造化本文の生成・型検査・実行時検証・HTML/PDF 生成が通る。
- [x] 検算対応の検証が通る。
- [x] 記述と SageMath 検算までの完了であり、Lean は未着手だと明記した。
