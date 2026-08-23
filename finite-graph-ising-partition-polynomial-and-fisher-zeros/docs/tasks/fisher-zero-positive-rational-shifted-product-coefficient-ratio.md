# Fisher 零点と正有理評価点との差の積

## 概要

一般有限グラフの重複度込み Fisher 零点について、任意の正有理評価点との差の積を、分配多項式の
評価値と最高次係数の比で与える。

## 背景・前提

- リポジトリ直下の `CLAUDE.md`、`AGENTS.md`、`docs/context/` と、このプロジェクトの `README.md` を読む。
- 依存する本文ラベルは `def_ising_partition_polynomial`、
  `theorem_partition_polynomial_degree_maximum_broken_edge_count`、
  `claim_partition_polynomial_coefficient_expansion`、`theorem_no_positive_rational_root` である。
- 係数を `Qbar[x]` へ移した分配多項式の一次因子分解を正有理点で評価する。

## スコープ

構造化本文へ一つの定理だけを追加し、その式変形を一行ずつ SageMath の厳密演算で検算する。
個々の零点の複素平面上の位置、距離、偏角、数値近似、熱力学極限は扱わない。

## 記号の帰属と R 脱出の見込み

- グラフ、スピン配位集合、零点添字集合は有限集合に属する。
- 次数と係数の多重度は `N`、Ising 分配多項式は `Z[x]`、評価点と評価値は `Q` に属する。
- Fisher 零点、評価点との差、有限積は `Qbar`、評価値と最高次係数の比は `Q` に属する。
- 複素平面への埋め込み、数値近似、実数、極限、積分を使わないため、`R/C` 脱出は起きない。

## 作業内容

### 構造化本文

- 分配多項式を `Qbar[x]` 上で重複度込み Fisher 零点の一次因子へ分解する。
- 一次因子分解を任意の `q in Q_{>0}` で評価する。
- 非零な最高次係数を消去し、正有理評価の下界から係数比の正値性を得る。

### SageMath 検算

- 一次因子分解の正有理点評価を検算する。
- 零点差積と評価値・最高次係数比の一致を検算する。
- 係数比の正値性と `q=1` で既存の全配位数表示へ一致することを検算する。

## 対象ファイル

- `structured-latex/content/main-text.ts`
- `sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio/`

## 完了条件

- [x] 一つの定理として、Fisher 零点と任意の正有理評価点との差の積が係数比で証明されている。
- [x] ステートメントと証明が整合している。
- [x] 参照が全て解決し、未解決参照がゼロである。
- [x] 記号の帰属を書き、`R/C` 脱出が無いことを明記した。
- [x] 変更した全 SageMath 検算が `PASS` する。
- [x] 構造化本文の生成・型検査・実行時検証・HTML/PDF 生成が通る。
- [x] 検算対応の検証が通る。
- [x] 記述と SageMath 検算までの完了であり、Lean は未着手だと明記した。
