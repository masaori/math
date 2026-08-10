# SageMath Check: 軌道を保つ置換の符号は軌道ごとの符号の積である

## 対象

**対象ラベル**: `def_orbit_permutation_sign` / `claim_permutation_sign_orbit_product`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件
  （軌道の上の全単射の符号 $\mathrm{sgn}_{O}(\psi)=(-1)^{\mathrm{inv}_{O}(\psi)}$）と主張 1 件
  （$\mathrm{sgn}(\varphi)=\prod_{O\in\mathcal{O}_L}\mathrm{sgn}_{O}(\varphi\!\restriction_{O})$）
- 併せて使う定義・主張: `def_row_config_order` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_preserving_permutation` / `def_orbit_restriction` /
  `def_inversion_count` / `def_permutation_sign` / `def_inversion_pairs` /
  `def_orbit_inversion_count` / `def_cross_orbit_inversion_pairs` /
  `claim_inversion_count_orbit_decomposition` / `claim_cross_orbit_inversion_pairs_even`

### 何を確定させるための検証か

シフト行列の特性多項式を軌道ごとの因子の積へ分解するには、行列式の和に現れる符号を
軌道ごとの符号の積へ分けねばならない。その分解がこの主張である。
前の 2 セクションで用意した転倒数の分解と、またぐ転倒対の個数の偶数性を代入すると、
またぐ項の寄与が $(-1)^{2k}=1$ となって消える。

1. `def_orbit_permutation_sign`。$\mathrm{sgn}_{O}(\psi)$ が $(-1)^{\mathrm{inv}_{O}(\psi)}$ で
   あり、値が $+1$ か $-1$ であること。加えて、$\mathrm{sgn}_{O}(\varphi\!\restriction_{O})$ が
   $O$ の中での $\varphi$ の値だけで決まること（$O$ の外の値を別の置換のものへ差し替えても
   変わらないこと）。
   **これを別に確かめる理由**: 下の 2 は符号の積の等式なので、$O$ の外の値が紛れ込んでいても
   積がたまたま合ってしまう場合がある。
2. `claim_permutation_sign_orbit_product`。人手証明の式変形の 3 つの段を**別々に**確かめる。
   最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
   - 転倒数の分解 $\mathrm{inv}(\varphi)=\sum_O\mathrm{inv}_O+|\mathrm{Inv}^{\ne}(\varphi)|$
   - またぐ項が消えること $(-1)^{|\mathrm{Inv}^{\ne}(\varphi)|}=1$
   - 有限和を指数とする冪が冪の積であること
     $(-1)^{\sum_O\mathrm{inv}_O}=\prod_O(-1)^{\mathrm{inv}_O}$

### 主張が空でないことの確認（走らせた L ごとに記録する）

2026-08-09 の実行では次のとおりであった。**またぐ項に中身があるのは $L=3$ だけである。**
すなわち $L=1,2$ の実行では、またぐ項の偶数性は $0$ が偶数であることしか見ていない。

| $L$ | 軌道を保つ置換 | 軌道 $\lvert\mathcal{O}_L\rvert$ | $\mathrm{sgn}(\varphi)=-1$ の例 | $\mathrm{sgn}_{O}=-1$ の例 | $\lvert\mathrm{Inv}^{\ne}(\varphi)\rvert>0$ の例 |
|---|---|---|---|---|---|
| 1 | 1 個 | 2 | 無い | 無い | 無い |
| 2 | 2 個 | 3 | ある | ある | 無い |
| 3 | 36 個 | 4 | ある | ある | ある |

$L=1$ では軌道を保つ置換が恒等写像だけなので、主張は $1=1\cdot1$ を見ているだけである。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| $\mathrm{sgn}_{O}$ の定義（上の 1） | $L=1,2,3$。$O$ の外の値の差し替えは $\mathfrak{S}^{\mathcal{O}}_L$ の元の値に限る |
| 積の等式とその 3 段（上の 2） | $L=1,2,3$ |

$\mathrm{sgn}_{O}$ が $O$ の外の値に依らないことを確かめるとき、差し替える値は
$\mathfrak{S}^{\mathcal{O}}_L$ の元が与えるものに限っている。$R_L$ から $R_L$ への任意の写像まで
走らせてはいない（Lean の `orbitPermSign_congr` はその一般の形で示してある）。

$L=3$ までに限ったのは、軌道を保つ置換の全体 $\mathfrak{S}^{\mathcal{O}}_L$ を
$\mathfrak{S}_L$ の全列挙から絞って作っているためである（$L=4$ では $16!$ 通りになる）。
軌道ごとの置換から組み立てれば $L=4$ も回せるが、その組み立てが成り立つことは
前のセクションの主張なので、ここで前提にすると検証が循環する。

### 計算の厳密性

有限集合の元の比較と数え上げ、および整数 $-1$ の冪だけであり、数として現れるのは
個数（$\mathbb{N}$ の元）と符号（$\mathbb{Z}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$\mathrm{sgn}_{O}$ の定義と局所性・積の等式・式変形の 3 段） |

```
sage sagemath/check/orbit-permutation-sign/check.sage
```
