# SageMath Check: 各因子の積が同じ値であるとき、軌道の集合にわたる 2 つの有限積の積は、その値の個数を指数とする冪である

## 対象

**対象ラベル**: `claim_prod_pair_eq_pow_card`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_config_orbit_set` / `def_second_polynomial_ring` /
  `def_second_constant_embedding` / `def_constant_polynomial` / `def_indeterminate_element`

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの和の積であり（`claim_shift_char_orbit_product`）、
その各因子は $t^{L}+\iota(-\kappa(1))$ を割り切る（`claim_orbit_sum_divides_pow_L`）。
この 2 つから「$\chi_U$ が $t^{L}+\iota(-\kappa(1))$ の冪を割り切る」を出すには、
**各因子の割り切り方を軌道の集合にわたって掛け合わせる**段が要る。ここで確かめるのはその段である。

$$
\text{すべての } O\in s \text{ について } a(O)\cdot b(O)=c
\quad\Longrightarrow\quad
\Bigl(\prod_{O\in s}a(O)\Bigr)\cdot\prod_{O\in s}b(O)=c^{\lvert s\rvert}
$$

確かめるのは次の 5 で、人手証明の段に 1 対 1 で対応する。

1. 出発点（$s=\emptyset$）の鎖の 5 段。空集合にわたる有限積が単位元であること 2 回・単位元・
   零乗・$\lvert\emptyset\rvert=0$。
2. 帰納法の一歩（$s$ に属さない $O_0$ を 1 つ足す）の鎖の 7 段。有限積を分ける段 2 つ・
   乗法の結合則と可換則・帰納法の仮定・仮定 $a(O_0)b(O_0)=c$・冪の定義・元の個数が 1 増えること。
3. 主張そのもの。$\mathcal{O}_L$ の部分集合 $s$ について等式が成り立つこと。
4. 主張が空虚でないこと。$\lvert s\rvert\ge2$ で、かつ $a(O)$ が $O$ によって実際に異なる例があること。
5. 仮定が外せないこと。1 つの $O_0$ だけ $a(O_0)b(O_0)\ne c$ にすると等式が破れること。

### $a,b,c$ の取り方

本文では $a,b$ は任意の写像、$c$ は任意の元なので、2 通りで確かめる。

- **応用の形**: $c=t^{L}+u$、$a(O)=t^{\lvert O\rvert}+u$、
  $b(O)=\sum_{j<L/\lvert O\rvert}t^{\lvert O\rvert j}$（`claim_orbit_sum_divides_pow_L` が与える形）。
- **一般の形**: $c=(t+1)(t+x)(t^{2}+3)$ とし、$O$ ごとに 3 因子の分け方を変えて $a(O),b(O)$ を割り当てる。
  $a(O)$ が $O$ によって実際に異なるので、応用の形に特有の構造（$a(O)$ が一定である・
  $b(O)$ が幾何級数の形である）を使っていないことが見える。

## 走らせた範囲

$L=1,\dots,5$ は $\mathcal{O}_L$ の**すべての部分集合**（$\lvert\mathcal{O}_L\rvert\le8$ なので高々 256 通り）。
$L=6$ は $\lvert\mathcal{O}_6\rvert=14$ で部分集合が 16384 通りあるので、
**全体集合・すべての 1 元部分集合・すべての 2 元部分集合の 106 通りに絞った**（打ち切りを隠さない）。
帰納法の一歩は、上の部分集合それぞれに対し、属さない軌道すべてを $O_0$ として走らせた（5076 通り）。
本文の主張は任意の $s$ についてのものなので、有限個で確かめたことは証明ではない。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の積と冪、有限集合の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（出発点の 5 段・一歩の 7 段を 5076 組・主張を 908 組・空虚でないこと・仮定が外せないこと） |

```
sage sagemath/check/prod-pair-eq-pow-card/check.sage
```
