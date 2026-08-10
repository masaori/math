# SageMath Check: 条件を満たす軌道の上の全単射が恒等写像と巡回シフトの制限だけであること

## 対象

**対象ラベル**: `claim_shift_orbit_preserving` / `claim_orbit_bijection_id_or_shift`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の 2 主張
  - 巡回シフト $S$ は軌道を保つ置換である（$S\in\mathfrak{S}^{\mathcal{O}}_L$。したがって
    各軌道 $O$ について $S\!\restriction_{O}\in\mathfrak{B}_{O}$）
  - $\psi\in\mathfrak{B}_{O}$ が任意の $\tau\in O$ で $\psi(\tau)=\tau$ または $\psi(\tau)=S(\tau)$ を
    満たすならば、$\psi=\mathrm{id}_{O}$ または $\psi=S\!\restriction_{O}$ である
- 併せて使う定義: `def_row_config_shift` / `def_row_config_shift_iterate` /
  `def_row_config_orbit` / `def_row_config_orbit_set` / `def_orbit_preserving_permutation` /
  `def_orbit_restriction` / `def_orbit_bijection_set`

### 何を確定させるための検証か

$\chi_U$ の軌道ごとの和（`claim_shift_char_orbit_product`）に零元でない項を与えうるのは、
各行配位をそれ自身かその像へ送る全単射だけである（`claim_shift_char_matrix_entry_zero`）。
その全単射が 2 つしか無いことを言う段であり、和が $t^{\lvert O\rvert}-1$ になることの土台である。

主張は**両向きに**確かめる。

- 健全性: 条件を満たす $\psi$ が $\mathrm{id}_{O}$ か $S\!\restriction_{O}$ に限ること（主張そのもの）。
- 非空虚性: $\mathrm{id}_{O}$ と $S\!\restriction_{O}$ が実際に条件を満たすこと。
  これを見ないと、条件を満たす $\psi$ が 1 つも無い場合に主張が自明に成り立ってしまう。
- $\lvert O\rvert\ge2$ の軌道では $\mathrm{id}_{O}\ne S\!\restriction_{O}$ であること
  （2 つが潰れていないこと）。$\lvert O\rvert=1$ の軌道では両者は一致し、条件を満たすのは 1 つだけである。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 軌道の個数 | 軌道の大きさ |
|---|---|---|
| 1 | 2 | 1, 1 |
| 2 | 3 | 1, 1, 2 |
| 3 | 4 | 1, 1, 3, 3 |
| 4 | 6 | 1, 1, 2, 4, 4, 4 |
| 5 | 8 | 1, 1, 5×6 |
| 6 | 14 | 1, 1, 2, 3, 3, 6×9 |

$\mathfrak{B}_{O}$ の全列挙は $\lvert O\rvert!$ 通りで、$\lvert O\rvert$ は $L$ を割り切るので
$L=6$ まで走らせられる。$\mathfrak{S}_L$ の全列挙は要らない（$S\!\restriction_{O}$ は $S$ から直接作る）。

### 計算の厳密性

有限集合の上の写像の比較と数え上げだけである。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | $L=1,\dots,6$ ですべて通過（$S$ が軌道を保つこと・$S\!\restriction_{O}\in\mathfrak{B}_{O}$・条件を満たす全単射が $\mathrm{id}_{O}$ と $S\!\restriction_{O}$ だけであること） |

```
sage sagemath/check/orbit-bijection-id-or-shift/check.sage
```
