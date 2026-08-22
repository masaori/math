# Fisher 零点逆数の三乗和と係数比

## 概要

一般有限グラフの重複度込み Fisher 零点について、逆数の三乗和を Ising 分配多項式の低次四係数の有理式で表す。

## 背景・前提

- リポジトリ直下の `CLAUDE.md`、`AGENTS.md`、`docs/context/` と、このプロジェクトの `README.md` を読む。
- 依存する本文ラベルは `theorem_fisher_zeros_nonzero`、`theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio`、`def_spin_configuration_set`、`def_broken_edge_set`、`def_broken_edge_multiplicity` である。
- Fisher 零点逆数族の一次から三次の基本対称式と有限和の分配律から、三次 Newton 恒等式を具体的に導く。

## スコープ

構造化本文へ一つの定理だけを追加し、その式変形を一行ずつ SageMath の厳密演算で検算する。次数三以上の場合だけを扱い、全辺二分割、複素平面上の配置、熱力学極限は扱わない。

## 記号の帰属と R 脱出の見込み

- グラフと零点添字集合は有限集合に属する。
- 次数と係数の多重度は `N` に属する。
- Ising 分配多項式は `Z[x]`、係数比は `Q`、Fisher 零点、その逆数、三乗、基本対称式は `Qbar` に属する。
- 複素平面への埋め込み、数値近似、実数、極限、積分を使わないため、`R/C` 脱出は起きない。

## 作業内容

### 構造化本文

- 次数を `d`、重複度込み Fisher 零点を `alpha_1,...,alpha_d` と置き、`d >= 3` を仮定する。
- 逆数族について有限和の三乗と一次・二次基本対称式の積を添字の一致型で展開し、三次 Newton 恒等式を導く。
- 逆数族の一次から三次の基本対称式を係数比へ置き換え、逆数三乗和を低次四係数と同定する。

### SageMath 検算

- 逆数族について、添字の一致型による二つの有限和展開を検算する。
- 三次 Newton 恒等式を取り出す各等号を検算する。
- 逆数族基本対称式の代入、符号整理、共通分母化、最終係数比を次数三以上の有限グラフ例で検算する。

## 対象ファイル

- `structured-latex/content/main-text.ts`
- `sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/`

## 完了条件

- [x] 一つの定理として、Fisher 零点逆数の三乗和と低次四係数の比が証明されている。
- [x] ステートメントと証明が整合している。
- [x] 参照が全て解決し、未解決参照がゼロである。
- [x] 記号の帰属を書き、`R/C` 脱出が無いことを明記した。
- [x] 変更した全 SageMath 検算が `PASS` する。
- [x] 構造化本文の生成・型検査・実行時検証・HTML/PDF 生成が通る。
- [x] 検算対応の検証が通る。
- [x] 記述と SageMath 検算までの完了であり、Lean は未着手だと明記した。
