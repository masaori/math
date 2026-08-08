# SageMath Check: シフト行列の位数（U^L = I）

## 対象

**対象ラベル**: `def_column_translation_iterate` / `claim_column_translation_iterate_apply` /
`claim_column_translation_period` / `def_row_config_shift_iterate` /
`claim_row_config_shift_iterate_apply` / `claim_row_config_shift_period` /
`claim_shift_matrix_pow` / `theorem_shift_matrix_order`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 2 件
  （平行移動の反復・巡回シフトの反復）と主張 4 件・定理 1 件
- 併せて使う定義: `def_lattice` / `def_column_translation` / `def_row_config_shift` /
  `claim_row_config_shift_bijective` / `def_shift_matrix` / `def_constant_polynomial` /
  `def_matrix_over_row_configs` / `claim_shift_matrix_right`

### 何を確定させるための検証か

本文は、シフト行列 $U$ が $L$ 乗すると単位行列になること $U^{L}=I$ を示している。
これは次のセクションで $U$ の固有値が 1 の $L$ 乗根（円分体 $\mathbb{Q}(\omega)$ の元）
であることを言うための足場である。この検証は、そこへ至る 6 つの主張を小さい $L$ で
総当たりに固定する。

1. `claim_column_translation_iterate_apply`。$\gamma^{[k]}(y)=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)$。
   左辺は本文の定め方（$\gamma^{[k+1]}=\gamma^{[k]}\circ\gamma$）をそのまま再帰で実装し、
   右辺は剰余類の加法から独立に作る。
2. `claim_column_translation_period`。$\gamma^{[L]}=\mathrm{id}$。
3. `claim_row_config_shift_iterate_apply`。$(S^{[k]}(\tau))(y)=\tau(\gamma^{[k]}(y))$。
   左辺は $S$ を $k$ 回施して作り、右辺は $\gamma^{[k]}$ で引き戻して作る（作り方が独立）。
4. `claim_row_config_shift_period`。$S^{[L]}=\mathrm{id}$。
5. `claim_shift_matrix_pow`。$(U^{k})_{\tau,\tau'}$ は $\tau'=S^{[k]}(\tau)$ なら $\kappa(1)$、
   そうでなければ $\kappa(0)$。左辺は行列の積を $k$ 回繰り返して作り、右辺は行配位に
   $S$ を $k$ 回施して作る（作り方が独立）。
6. `theorem_shift_matrix_order`。$U^{L}=I$（全成分の一致）。

最終の等式 $U^{L}=I$ だけを見ないのは、途中の反復の向きを取り違えていても
$L$ 乗した結果はどちらでも単位行列になり、誤りが隠れるからである。
そこで各段（$\gamma^{[k]}$ の値・$S^{[k]}$ の値・$U^{k}$ の全成分）を別々に確かめている。

### 主張が空でないことの確認

- $L=2,3,4$ で、$1\le k<L$ のとき $U^{k}\ne I$ である
  （$U^{L}=I$ が「どの冪でも単位行列」という自明な理由で成り立っているのではないこと）。
- $L=3$ で、反復の向きを取り違えた実装（$\gamma$ の逆向き $\gamma'$ で引き戻す）では 3 が破れる
  （この検証が向きを固定できていること）。

なお $L=1$ では $S$ が恒等写像なので $U=I$ であり、6 は自明に成り立つ。
$L=1$ を走らせているのは定義が退化した場合でも壊れないことを見るためであって、
主張の中身を確かめているのは $L\ge2$ の側である。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 反復の回数 $k$ | 行列の冪 $k$ |
|---|---|---|---|
| 1 | 2 | $0\le k\le 2$ | $1\le k\le 2$ |
| 2 | 4 | $0\le k\le 4$ | $1\le k\le 3$ |
| 3 | 8 | $0\le k\le 6$ | $1\le k\le 4$ |
| 4 | 16 | $0\le k\le 8$ | $1\le k\le 5$ |

各 $L$ について、行配位・列番号・行列の成分はいずれも**総当たり**である。
$L$ の全体と $k$ の全体は無限集合なので、$L$ は 4 つの値に、$k$ は上の範囲に限っている。
$k$ の上限を $2L$（行列の冪は $L+1$）に取ったのは、周期 $L$ を 1 周以上こえたところまで見るためである。

### 計算の厳密性

すべて `ZZ` / `ZZ[x]` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。
整数を成分に置く経路は本文と同じく `const_poly`（$\kappa$）だけを通す。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,2,3,4$。上の 1〜6 と「主張が空でないことの確認」） |

```
sage sagemath/check/shift-matrix-order/check.sage
```
