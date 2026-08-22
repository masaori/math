# Fisher 零点の基本対称式と係数比

## 概要

一般有限グラフの重複度込み Fisher 零点について、任意次数の基本対称式を Ising 分配多項式の
対応する高次係数と最高次係数の比で表す。

## 背景・前提

- リポジトリ直下の `CLAUDE.md`、`AGENTS.md`、`docs/context/` と、このプロジェクトの `README.md` を読む。
- 依存する本文ラベルは `def_finite_graph_input`、`def_ising_partition_polynomial`、
  `claim_partition_polynomial_coefficient_expansion`、
  `theorem_partition_polynomial_degree_maximum_broken_edge_count` である。
- 既存の Fisher 零点積・零点和の係数比表示を、一次因子分解の任意係数へ拡張する。

## スコープ

構造化本文へ一つの定理だけを追加し、その式変形を一行ずつ SageMath の厳密演算で検算する。
全辺二分割、複素平面上の配置、熱力学極限は扱わない。

## 記号の帰属と ℝ 脱出の見込み

- グラフ、零点添字集合、その部分集合は有限集合に属する。
- 次数、係数の多重度、部分集合の元数は `N` に属する。
- Ising 分配多項式は `Z[x]`、係数比は `Q`、Fisher 零点と基本対称式は `Qbar` に属する。
- 複素平面への埋め込み、数値近似、実数、極限、積分を使わないため、`R/C` 脱出は起きない。

## 作業内容

### 構造化本文

- 次数を `d`、重複度込み Fisher 零点を `alpha_1,...,alpha_d` と置く。
- 任意の `k in {0,...,d}` について、`k` 個の零点積の総和を
  `(-1)^k Omega_G(d-k)/Omega_G(d)` と同定する。
- 一次因子分解の `x^(d-k)` 係数を選択積で展開し、符号を取り出し、非零な最高次係数で割る。

### SageMath 検算

- `QQbar[x]` の厳密な一次因子分解から任意の `k` の係数を復元する。
- 選択積から `(-1)^k` を取り出す式を検算する。
- 基本対称式と係数比の一致を、次数零を含む有限グラフ例で検算する。

## 対象ファイル

- `structured-latex/content/main-text.ts`
- `sagemath/check/fisher-zero-elementary-symmetric-coefficient-ratio/`

## 完了条件

- [x] 一つの定理として、任意次数の基本対称式と係数比が証明されている。
- [x] ステートメントと証明が整合している。
- [x] 参照が全て解決し、未解決参照がゼロである。
- [x] 記号の帰属を書き、`R/C` 脱出が無いことを明記した。
- [x] 変更した全 SageMath 検算が `PASS` する。
- [x] 構造化本文の生成・型検査・実行時検証・HTML/PDF 生成が通る。
- [x] 検算対応の検証が通る。
- [x] 記述と SageMath 検算までの完了であり、Lean は未着手だと明記した。
