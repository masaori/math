# SageMath Check: 軌道を保つ置換が与える項は、軌道ごとの因子の積である

## 対象

**対象ラベル**: `claim_const_embedding_prod` / `claim_prod_orbit_decomposition` /
`def_orbit_term_factor` / `claim_orbit_term_factorization`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件
  （軌道の因子 $W_{O}(B,\psi)=\iota(\kappa(\mathrm{sgn}_{O}(\psi)))\cdot\prod_{\tau\in O}B_{\tau,\psi(\tau)}$）と
  主張 3 件（$\iota\circ\kappa$ が有限積を保つこと・有限積の軌道ごとの分解・項の分解）
- 併せて使う定義・主張: `def_constant_polynomial` / `def_second_constant_embedding` /
  `def_second_matrix` / `def_second_determinant` / `def_characteristic_matrix` /
  `def_shift_matrix` / `def_row_config_order` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `claim_row_config_orbit_partition` /
  `def_orbit_preserving_permutation` / `def_orbit_restriction` /
  `def_permutation_sign` / `def_orbit_inversion_count` / `def_orbit_permutation_sign` /
  `claim_permutation_sign_orbit_product`

### 何を確定させるための検証か

シフト行列の特性多項式 $\chi_U$ を軌道ごとの因子の積へ組み替えるには、まず和の 1 つの項を
軌道ごとの因子の積へ分けねばならない。その分解がこの主張である。
前セクションの符号の積表示と、ここで示す有限積の軌道ごとの分解を代入すると、
2 つの有限積の積として書け、成分ごとにまとめて $\prod_{O}W_{O}$ になる。

1. `claim_const_embedding_prod`。$\iota(\kappa(\prod_i n_i))=\prod_i\iota(\kappa(n_i))$。
   整数の組を長さ 0（空の積）から 3 まで総当たりし、$0$ を含む組・負の数を含む組も走らせる。
2. `claim_prod_orbit_decomposition`。$\prod_{\tau\in R_L}f(\tau)=\prod_{O}\prod_{\tau\in O}f(\tau)$。
   $f$ は行配位ごとに相異なる元を返すものを使う（**すべて同じ値を返す $f$ だと、軌道の切り方を
   取り違えていても等式が成り立ってしまう**）。軌道の全体が分割であること（合併・互いに素）も別に見る。
3. `def_orbit_term_factor`。$W_{O}$ が定義どおりであること、および $O$ の中の値だけで決まること
   （$O$ の外の値を別の置換のものへ差し替えても変わらないこと）。
   **これを別に確かめる理由**: 下の 4 は積の等式なので、$O$ の外の値が紛れ込んでいても
   たまたま積が合ってしまう場合がある。
4. `claim_orbit_term_factorization`。人手証明の式変形の 3 つの段を**別々に**確かめる。
   最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
   - $\iota(\kappa(\mathrm{sgn}(\varphi)))=\prod_{O}\iota(\kappa(\mathrm{sgn}_{O}(\varphi\!\restriction_O)))$
   - $\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}=\prod_{O}\prod_{\tau\in O}B_{\tau,\varphi(\tau)}$
   - 2 つの有限積の積が、成分ごとの積の有限積であること

### 行列を 2 種類走らせている理由（ch(U) だけでは足りない）

主張は任意の $B\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x][t])$ についてのものなので、次の 2 つで走らせた。

| 行列 | $L=3$ で零元でない項の個数（軌道を保つ置換 36 個のうち） |
|---|---|
| シフト行列の特性行列 $\mathrm{ch}(U)$ | 4 個 |
| 成分がすべて零元でない一般の行列 | 36 個 |

$\mathrm{ch}(U)$ は成分の大半が零元なので、**36 個の項のうち 32 個は $0=0$ を見ているだけ**であり、
積の組み替えを何も確かめていない。一般の行列を併せて走らせることでこれを埋めている。

### 主張が空でないことの確認（走らせた L ごとに記録する）

2026-08-09 の実行では次のとおりであった。

| $L$ | 軌道を保つ置換 | 軌道 $\lvert\mathcal{O}_L\rvert$ | $\mathrm{ch}(U)$ で零元でない項 | 一般の行列で零元でない項 |
|---|---|---|---|---|
| 1 | 1 個 | 2 | 1 個 | 1 個 |
| 2 | 2 個 | 3 | 2 個 | 2 個 |
| 3 | 36 個 | 4 | 4 個 | 36 個 |

$L=1$ では軌道を保つ置換が恒等写像だけなので、主張は 1 個の項しか見ていない。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| $\iota\circ\kappa$ が有限積を保つこと（上の 1） | 整数の組 156 通り（長さ 0〜3、値は $-2,-1,0,1,3$） |
| 有限積の軌道ごとの分解と分割（上の 2） | $L=1,2,3,4$ |
| $W_{O}$ の定義と局所性（上の 3） | $L=1,2,3$。$O$ の外の値の差し替えは $\mathfrak{S}^{\mathcal{O}}_L$ の元の値に限る |
| 項の分解とその 3 段（上の 4） | $L=1,2,3$。行列は $\mathrm{ch}(U)$ と一般の行列の 2 種 |

$L=3$ までに限ったのは、軌道を保つ置換の全体 $\mathfrak{S}^{\mathcal{O}}_L$ を
$\mathfrak{S}_L$ の全列挙から絞って作っているためである（$L=4$ では $16!$ 通りになる）。
軌道ごとの置換から組み立てれば $L=4$ も回せるが、その組み立てが成り立つことは
前のセクションの主張なので、ここで前提にすると検証が循環する。
$W_{O}$ が $O$ の外の値に依らないことを確かめるとき、差し替える値は
$\mathfrak{S}^{\mathcal{O}}_L$ の元が与えるものに限っている（Lean の `orbitFactor` は
一般の写像で受けてある）。

### 計算の厳密性

有限集合の元の比較と数え上げ、整数 $-1$ の冪、および $\mathbb{Z}[x][t]$ の積だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$\iota\circ\kappa$ の積の保存・有限積の軌道ごとの分解・$W_{O}$ の定義と局所性・項の分解とその 3 段） |

```
sage sagemath/check/orbit-term-factorization/check.sage
```
