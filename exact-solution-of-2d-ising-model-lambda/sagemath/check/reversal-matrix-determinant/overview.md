# SageMath Check: 反転置換行列の行列式は一である

**対象ラベル**: `claim_reversal_matrix_determinant_one`, `def_integer_matrix_determinant`

本文の互換の作用・反転の符号・零項の消去・行列式展開を、以下の順で一行ずつ検算する。
`_prelude.sage` が定める向き付き辺は `(e,d)`（`e=1,…,2L²`, `d=0,1`）で、辺番号を先に比べる辞書式順序に並べる。
整数行列の成分は列の辺が行の辺の反転なら一、それ以外は零である。

| 本文の段 | 式ペア・検証内容 | ファイル | 状態 | 結果 |
|---|---|---|---|---|
| 支持集合 | 各互換の動かす集合は指定した二点、異なる辺の二点集合は互いに素 | `check_pair_support.sage` | PASS | 支持集合110件、集合対1,903件 |
| 交換可能性 | 異なる辺の二互換の合成順を交換する | `check_swap_commutation.sage` | PASS | 1,903組の互換対、計160,204引数 |
| 作用鎖の先頭 | $T(f,d)=\tau_f(f,d)$ | `check_composition_action.sage` | PASS | 220引数 |
| 作用鎖の次行 | $\tau_f(f,d)=(f,1-d)$ | `check_swap_action.sage` | PASS | 220引数 |
| 作用鎖の末尾 | $(f,1-d)=\iota(f,d)$ | `check_reversal_action.sage` | PASS | 220引数 |
| 符号鎖 | $\operatorname{sgn}\iota=\operatorname{sgn}(\bigcirc_e\tau_e)$ | `check_sign_composition_substitution.sage` | PASS | 5辺長 |
| 符号鎖 | $\operatorname{sgn}(\bigcirc_e\tau_e)=\prod_e\operatorname{sgn}\tau_e$ | `check_sign_multiplicativity.sage` | PASS | 5辺長 |
| 符号鎖 | $\prod_e\operatorname{sgn}\tau_e=\prod_e(-1)$ | `check_transposition_signs.sage` | PASS | 5辺長 |
| 符号鎖 | $\prod_e(-1)=(-1)^{|E_L|}$ | `check_constant_sign_product.sage` | PASS | 5辺長 |
| 符号鎖 | $(-1)^{|E_L|}=(-1)^{2L^2}$ | `check_edge_cardinality.sage` | PASS | 5辺長 |
| 符号鎖 | $(-1)^{2L^2}=((-1)^2)^{L^2}$ | `check_power_multiplication.sage` | PASS | 5辺長 |
| 符号鎖 | $((-1)^2)^{L^2}=1^{L^2}$ | `check_negative_one_square.sage` | PASS | 5辺長 |
| 符号鎖 | $1^{L^2}=1$ | `check_unit_power.sage` | PASS | 5辺長 |
| 零項 | $(J_L)_{w,\sigma(w)}=0$ | `check_mismatch_entry.sage` | PASS | 451置換 |
| 零項 | $\prod_w(J_L)_{w,\sigma(w)}=0$ | `check_zero_row_product.sage` | PASS | 451置換 |
| 零項 | $\operatorname{sgn}\sigma\prod_w(J_L)_{w,\sigma(w)}=\operatorname{sgn}\sigma\cdot0$ | `check_zero_product_substitution.sage` | PASS | 451置換 |
| 零項 | $\operatorname{sgn}\sigma\cdot0=0$ | `check_zero_weighted_term.sage` | PASS | 451置換 |
| 行列式鎖 | $\det J_L=\sum_\sigma\operatorname{sgn}\sigma\prod_w(J_L)_{w,\sigma(w)}$ | `check_determinant_definition.sage` | PASS | 5辺長 |
| 行列式鎖 | 上の和 $=\operatorname{sgn}\iota\prod_w(J_L)_{w,\iota(w)}$ | `check_sum_single_reversal.sage` | PASS | 5辺長 |
| 行列式鎖 | 反転の項 $=\operatorname{sgn}\iota\prod_w1$ | `check_selected_entries.sage` | PASS | 5辺長 |
| 行列式鎖 | $\operatorname{sgn}\iota\prod_w1=\operatorname{sgn}\iota\cdot1$ | `check_unit_product.sage` | PASS | 5辺長 |
| 行列式鎖 | $\operatorname{sgn}\iota\cdot1=\operatorname{sgn}\iota$ | `check_unit_multiplication.sage` | PASS | 5辺長 |
| 行列式鎖 | $\operatorname{sgn}\iota=1$ | `check_reversal_sign_one.sage` | PASS | 5辺長 |
| 独立照合 | `ZZ` 行列の `det()`、SageMath の置換符号、全非零項の一致 | `check.sage` | PASS | 5行列すべて行列式一 |

## 列挙範囲と行列式の計算

すべて $L=1,2,3,4,5$ で実行した。向き付き辺数は順に $4,16,36,64,100$。
支持集合と互換の交換可能性は、これらの格子の全辺・全ての異なる辺対・全向き付き辺を対象とする。
符号は辞書式順位の転倒数を直接数えて $(-1)$ の整数冪として計算する。

零項の検査に使う置換は次の範囲であり、$L\ge2$ について全置換を列挙したとは主張しない。

- $L=1$: 四つの向き付き辺の全24置換。
- $L=2,3,4,5$: 向き付き辺数を $n=4L^2$ とし、辞書式順位 $k\in\{0,\ldots,n-1\}$ の巡回シフト $k\mapsto k+c\pmod n$ を全 $c\in\{0,\ldots,n-1\}$ について取る。加えて反転、および各 $k\in\{0,\ldots,n-2\}$ に対する隣接互換 $(k\ k+1)$ を反転に左合成した置換を取る。重複を除いた個数は順に32、72、128、200。

合計456置換から各辺長の反転一個ずつを除いた451置換について、不一致のある最小辞書式順位を選び、零成分と零項の四行を検算した。

**行列式の和は、この代表置換集合の和で代用していない。** $L=1$ は全24項の Leibniz 和を計算する。
$L\ge2$ は各行の全非零列を実際の整数行列から列挙し、列の重複がない組合せをすべて生成する。
列挙から外れる置換は零成分を含むため寄与しない。生成された全非零項は各辺長で反転の一項だけだった。
これらの和を、成分から独立に計算する SageMath の `ZZ` 行列の `det()` と照合した。

有限集合・自然数・整数の厳密計算だけを使う。浮動小数点と実数体・複素数体は使わない。
この有限範囲の検算は一般の辺長についての証明を代替しない。

## 実行

プロジェクト直下で実行する。`check.sage` は表の全行別検査を呼び出し、その後で独立照合を行う。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/reversal-matrix-determinant/check.sage
```

2026-10-04 実行: 行別21本、支持集合と交換可能性の2本、独立照合がすべて PASS。
初回の起動は検査ファイル生成時の出力先指定が誤っていたため `check.sage` が存在せず ERROR となった。
数式の検算には到達していない。出力先を直して生成し直し、上記コマンドで全件通過した。
