# SageMath Check: 軌道の上の巡回シフトの制限の符号は $(-1)^{\lvert O\rvert-1}$ である

## 対象

**対象ラベル**: `claim_orbit_shift_restriction_sign`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_configuration` / `def_row_config_order` / `def_row_config_shift` /
  `def_row_config_shift_iterate` / `def_row_config_shift_minimal_period` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_restriction` / `def_orbit_bijection_set` /
  `def_orbit_inversion_count` / `def_orbit_permutation_sign` / `def_orbit_transposition` /
  `def_orbit_transposition_composite`

### 何を確定させるための検証か

各軌道の因子の和が $t^{\lvert O\rvert}-1$ になることを言うために、軌道の上の巡回シフトの制限
$S\!\restriction_{O}$ の符号が要る。ここで確かめるのは

$$\mathrm{sgn}_{O}\bigl(S\!\restriction_{O}\bigr)=(-1)^{\lvert O\rvert-1}$$

である。人手証明は、基点 $\tau_0\in O$ を取って $\lvert O\rvert=e(\tau_0)$ を出し、
$\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$（前のセクション）と
反復合成の符号が $(-1)^{k}$ であること（前のセクション）をつなぐ。
確かめるのは次の 5 つで、人手証明の段に 1 対 1 で対応する。

1. 準備。どの軌道も空でないこと（基点が取れること）。
2. 準備。$\lvert O\rvert=e(\tau_0)$ かつ $e(\tau_0)\ge1$、したがって $\lvert O\rvert-1<e(\tau_0)$ であること。
3. 第 1 の等号。$\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}$ であること。
4. 主張そのもの。$\mathrm{sgn}_{O}(S\!\restriction_{O})=(-1)^{\lvert O\rvert-1}$ であること。
5. 右辺が基点によらないこと。どの $\tau_0\in O$ から作った $\Psi^{O,\tau_0}_{\lvert O\rvert-1}$ も
   同じ符号を与えること（左辺に $\tau_0$ が現れないことの裏取り）。

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 軌道の個数 | 準備の件数（軌道と基点の組） | 第 1 の等号の件数 | 主張の件数 |
|---|---|---|---|---|
| 1 | 2 | 2 | 2 | 2 |
| 2 | 3 | 4 | 4 | 3 |
| 3 | 4 | 8 | 8 | 4 |
| 4 | 6 | 16 | 16 | 6 |
| 5 | 8 | 32 | 32 | 8 |
| 6 | 14 | 64 | 64 | 14 |

$L=1$ では軌道がどちらも 1 元なので $\lvert O\rvert-1=0$ であり、符号は $+1$ である。
$L\ge2$ には元の個数が偶数の軌道があり、そこでは符号が $-1$ になる（すなわち
右辺の $(-1)^{\lvert O\rvert-1}$ は $+1$ に潰れていない）。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1・2・3・5 | $L=1,\dots,6$。各軌道 $O$、各基点 $\tau_0\in O$ をすべて |
| 上の 4 | $L=1,\dots,6$。各軌道 $O$ をすべて |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない
（証明は前の 2 つの主張をつなぐ段である）。$L=7$ 以上へ伸ばしていないのは本文の他の検証と
範囲を揃えたためであり、計算量による打ち切りではない。

### 計算の厳密性

有限集合の元の相等・数え上げと整数の積だけである。符号は $(-1)$ の整数冪として計算しており、
$\mathbb{Z}$ の中で閉じている。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備・第 1 の等号・主張・基点によらないこと） |

```
sage sagemath/check/orbit-shift-restriction-sign/check.sage
```
