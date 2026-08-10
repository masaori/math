# SageMath Check: 互換の反復合成の符号は $(-1)^k$ である

## 対象

**対象ラベル**: `claim_orbit_transposition_composite_sign`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_configuration` / `def_row_config_order` / `def_row_config_shift` /
  `def_row_config_shift_iterate` / `def_row_config_shift_minimal_period` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_bijection_set` / `def_orbit_inversion_count` /
  `def_orbit_permutation_sign` / `def_orbit_transposition` / `def_orbit_transposition_composite`

### 何を確定させるための検証か

軌道の上の巡回シフトの制限 $S\!\restriction_{O}$ の符号が $(-1)^{\lvert O\rvert-1}$ であることは、
$S\!\restriction_{O}=\Psi^{O,\tau_0}_{\lvert O\rvert-1}$ であること（前のセクション）と、
反復合成の符号が $(-1)^{k}$ であること（ここ）から出す。ここで確かめるのは後者、すなわち

$$k<e(\tau_0)\ \Longrightarrow\ \mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k}\bigr)=(-1)^{k}$$

である。人手証明は、準備 2 つ（反復の相異なること・互換の符号が $-1$ であること）を置いてから
$k$ についての帰納法で進む。確かめるのは次の 6 つで、人手証明の段に 1 対 1 で対応する。

1. 準備の第一。$1\le j<e(\tau_0)$ ならば $\tau_0\ne S^{[j]}(\tau_0)$ であること。
2. 準備の第二。$O$ の相異なる 2 点 $\tau_a,\tau_b$ について
   $\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_a,\tau_b}\bigr)=-1$ であること。
   あわせて $t_{\tau_a,\tau_b}=t_{\tau_b,\tau_a}$（写像として一致すること）も確かめる。
   人手証明が $\tau_b\prec\tau_a$ の場合にこれを使うためである。
3. 帰納法の出発点。$\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{0}\bigr)=\mathrm{sgn}_{O}(\mathrm{id}_{O})=+1$。
4. 帰納法の一歩。$k+1<e(\tau_0)$ のとき
   $\mathrm{sgn}_{O}(\Psi_{k+1})=\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_0,S^{[k+1]}(\tau_0)}\bigr)\cdot\mathrm{sgn}_{O}(\Psi_{k})$
   であること（符号の乗法性をこの場面で当てた形）。
5. 主張そのもの。$k<e(\tau_0)$ のとき $\mathrm{sgn}_{O}(\Psi_{k})=(-1)^{k}$ であること。
6. 上界 $k<e(\tau_0)$ が外せないこと。

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 準備の第一の件数 | 準備の第二の件数 | 帰納法の出発点 | 帰納法の一歩 | 主張の件数 | 上界を外すと破れる最小の $k$ |
|---|---|---|---|---|---|---|
| 1 | 0 | 0 | 2 | 0 | 2 | 1 |
| 2 | 2 | 2 | 4 | 2 | 6 | 1, 2 |
| 3 | 12 | 12 | 8 | 12 | 20 | 1, 3 |
| 4 | 38 | 38 | 16 | 38 | 54 | 1, 2, 4 |
| 5 | 120 | 120 | 32 | 120 | 152 | 1, 5 |
| 6 | 284 | 284 | 64 | 284 | 348 | 1, 2, 3, 6 |

$L=1$ では軌道がどちらも 1 元なので、準備の 2 つと帰納法の一歩は空である（$k=0$ の場合しか無い）。
$L=2$ 以上ではどれも空でない。最後の列は、$k\ge e(\tau_0)$ で等式が実際に破れることを示している
（$k=e(\tau_0)$ では合成する互換が $t^{O}_{\tau_0,\tau_0}$ すなわち恒等写像になり、
符号が $-1$ 倍されないためである）。すなわち上界の条件は本文の主張から外せない。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1 | $L=1,\dots,6$。各軌道 $O$、各基点 $\tau_0\in O$、$1\le j<e(\tau_0)$ をすべて |
| 上の 2 | 同じ範囲の各軌道について、$O$ の相異なる 2 点の順序対をすべて |
| 上の 3・4・5 | 同じ範囲の各軌道・各基点について $k=0,\dots,e(\tau_0)-1$ をすべて |
| 上の 6 | 同じ範囲の各軌道・各基点について $k=e(\tau_0),\dots,2e(\tau_0)+1$ |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない
（証明は $k$ についての帰納法である）。$L=7$ 以上へ伸ばしていないのは本文の他の検証と
範囲を揃えたためであり、計算量による打ち切りではない。

### 計算の厳密性

有限集合の元の相等・数え上げと整数の積だけである。符号は $(-1)$ の整数冪として計算しており、
$\mathbb{Z}$ の中で閉じている。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備 2 つ・帰納法の出発点と一歩・主張・上界が外せないこと） |

```
sage sagemath/check/orbit-transposition-composite-sign/check.sage
```
