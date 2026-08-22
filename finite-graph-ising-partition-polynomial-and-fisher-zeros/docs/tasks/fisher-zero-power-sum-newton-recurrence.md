# Fisher 零点冪和の Newton 漸化式と係数比

## 概要

一般有限グラフの重複度込み Fisher 零点について、任意次数の冪和を Ising 分配多項式の高次係数と
それ以前の冪和から再帰的に決める。

## 背景・前提

- リポジトリ直下の `CLAUDE.md`、`AGENTS.md`、`docs/context/` と、このプロジェクトの `README.md` を読む。
- 依存する本文ラベルは `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`、
  `theorem_partition_polynomial_degree_maximum_broken_edge_count`、`claim_partition_polynomial_coefficient_expansion` である。
- Fisher 零点の任意次数の基本対称式と有限和の分配律から、Newton 漸化式を具体的に導く。

## スコープ

構造化本文へ一つの定理だけを追加し、その式変形を一行ずつ SageMath の厳密演算で検算する。
逆数族、全辺二分割、複素平面上の配置、熱力学極限は扱わない。

## 記号の帰属と R 脱出の見込み

- グラフ、零点添字集合、その部分集合は有限集合に属する。
- 次数、冪指数、係数の多重度、部分集合の元数は `N` に属する。
- Ising 分配多項式は `Z[x]`、係数比と冪和は `Q`、Fisher 零点、有限積、有限和は `Qbar` に属する。
- 複素平面への埋め込み、数値近似、実数、極限、積分を使わないため、`R/C` 脱出は起きない。

## 作業内容

### 構造化本文

- 次数を `d`、重複度込み Fisher 零点を `alpha_1,...,alpha_d` と置く。
- 任意の `k in {1,...,d}` について、基本対称式と冪和の積を、冪を取る添字が選択部分集合に属する場合と
  属さない場合へ分ける。
- 交代和で中間和を相殺し、`k` 次 Newton 漸化式を導く。
- 基本対称式を高次係数比へ置き換え、`k` 次冪和をそれ以前の冪和と高次係数から再帰的に表す。

### SageMath 検算

- 添字が選択部分集合に属する場合と属さない場合への分割を検算する。
- 交代和による中間和の相殺を検算する。
- Newton 漸化式、基本対称式の係数比代入、最終係数漸化式を検算する。

## 対象ファイル

- `structured-latex/content/main-text.ts`
- `sagemath/check/fisher-zero-power-sum-newton-recurrence/`

## 完了条件

- [x] 一つの定理として、任意次数の Fisher 零点冪和の Newton 漸化式と高次係数比が証明されている。
- [x] ステートメントと証明が整合している。
- [x] 参照が全て解決し、未解決参照がゼロである。
- [x] 記号の帰属を書き、`R/C` 脱出が無いことを明記した。
- [x] 変更した全 SageMath 検算が `PASS` する。
- [x] 構造化本文の生成・型検査・実行時検証・HTML/PDF 生成が通る。
- [x] 検算対応の検証が通る。
- [x] 記述と SageMath 検算までの完了であり、Lean は未着手だと明記した。
