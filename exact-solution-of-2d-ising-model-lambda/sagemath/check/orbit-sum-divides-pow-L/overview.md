# SageMath Check: 軌道ごとの和は、格子の一辺を指数とする冪と単位元の逆元との和の因子である

## 対象

**対象ラベル**: `claim_orbit_sum_divides_pow_L`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_config_orbit_set` / `def_orbit_bijection_set` / `def_orbit_term_factor` /
  `def_shift_matrix` / `def_characteristic_matrix` / `def_indeterminate_element` /
  `def_second_constant_embedding` / `def_constant_polynomial`
- 引く主張: `claim_row_config_orbit_card` / `claim_row_config_minimal_period_divides_L` /
  `claim_power_sum_telescope` / `claim_orbit_sum_two_terms`

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの和の積である（`claim_shift_char_orbit_product`）。
その各因子の値は $t^{\lvert O\rvert}+\iota(-\kappa(1))$ であり（`claim_orbit_sum_two_terms`）、
軌道の元の個数は格子の一辺を割り切る。ここで確かめるのは、その 2 つを合わせると
**各因子が $t^{L}+\iota(-\kappa(1))$ を $\mathbb{Z}[x][t]$ の中で割り切る**ことである。

$$
t^{L}+\iota\bigl(-\kappa(1)\bigr)
=\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)\Bigr)
 \cdot\sum_{j\in\{j'\in\mathbb{N}\,\mid\,j'<k\}}t^{\lvert O\rvert j}
\qquad(L=\lvert O\rvert\cdot k)
$$

確かめるのは次の 9 で、人手証明の段に 1 対 1 で対応する（$u:=\iota(-\kappa(1))$ と書く）。

1. 準備。各軌道 $O$ について $O=O(\tau_0)$ を満たす $\tau_0$ が存在すること。
2. $\lvert O\rvert=e(\tau_0)$ であること。
3. $e(\tau_0)$ が $L$ を割り切り、$L=\lvert O\rvert k$ を満たす $k\in\mathbb{N}$ がただ 1 つあること。
4. 鎖の第 1 段。$t^{L}+u=t^{\lvert O\rvert k}+u$。
5. 鎖の第 2 段。$t^{\lvert O\rvert k}+u=(t^{\lvert O\rvert}+u)\sum_{j<k}t^{\lvert O\rvert j}$。
6. 鎖の第 3 段。$t^{\lvert O\rvert}+u=\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)$。
7. 主張そのもの。
8. 主張が空虚でないこと。商が単位元でない（$k\ge2$、すなわち $\lvert O\rvert<L$ の）軌道が実際にあること。
9. 整除関係そのもの。$\mathbb{Z}[x][t]$ の中で剰余が零元であること。

### 主張が空虚でないことの確認

$k=1$（$\lvert O\rvert=L$）の軌道では商が単位元になり、等式は成り立つが何も確かめたことにならない。
2026-08-10 の実行では $k\ge2$ の軌道が $L=2$ で 2 個、$L=3$ で 2 個、$L=4$ で 3 個、
$L=5$ で 2 個、$L=6$ で 5 個あった（$L=1$ では軌道の元の個数がすべて 1 で $k=1$ となり、
この検証では空である）。

## 走らせた範囲

$L=1,\dots,6$ のすべての軌道。第 3 段は $\mathfrak{B}_{O}$ を全列挙して確かめている
（$\lvert O\rvert\le6$ なので $\lvert\mathfrak{B}_{O}\rvert\le720$）。
本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の等式と剰余、整数の冪、有限集合の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備・整除する $k$ の存在と一意性・鎖の 3 段・主張・空虚でないこと・剰余が零元） |

```
sage sagemath/check/orbit-sum-divides-pow-L/check.sage
```
