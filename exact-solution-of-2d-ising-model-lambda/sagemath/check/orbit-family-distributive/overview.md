# SageMath Check: 軌道の部分集合にわたる有限積の分配則

## 対象

**対象ラベル**: `claim_orbit_family_distributive`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
  （$\prod_{O\in s}\bigl(\sum_{\psi\in\mathfrak{B}_O}g(O,\psi)\bigr)=\sum_{\alpha\in\mathfrak{A}(s)}\prod_{O\in s}g(O,\alpha(O))$）
- 併せて使う定義・主張: `def_row_config_orbit` / `def_row_config_orbit_set` /
  `def_orbit_bijection_set` / `def_orbit_family_on_subset` / `claim_orbit_family_insert_bijection`

### 何を確定させるための検証か

本文はこの分配則を $s$ の元の個数についての帰納法で示す。一歩に要る 1 対 1 対応
（$\mathfrak{A}(\{O_0\}\cup s)\leftrightarrow\mathfrak{B}_{O_0}\times\mathfrak{A}(s)$）は
`sagemath/check/orbit-family-insert` で確かめてあるので、ここで確かめるのは分配則そのものである。

1. **出発点。** $s=\emptyset$ で両辺とも $\mathbb{Z}[x][t]$ の $1$ になること
   （空集合にわたる有限積が $1$、$\mathfrak{A}(\emptyset)$ がちょうど 1 元）。
2. **主張そのもの。** $s$ を動かして両辺を**別々に**組み立て、多項式として等しいこと。
   左辺は「各軌道で和を取ってから積」、右辺は「組ごとに積を取ってから和」であり、
   片方から他方を代入で作っていない（作ると構成から自明になり何も確かめない）。
3. **一歩。** $O_0\notin s$ のとき
   $\mathrm{LHS}(\{O_0\}\cup s)=\bigl(\sum_{\psi\in\mathfrak{B}_{O_0}}g(O_0,\psi)\bigr)\cdot\mathrm{LHS}(s)$
   であること（本文の一歩の第 1 の等号）。あわせて右辺の項数が
   $\lvert\mathfrak{A}(\{O_0\}\cup s)\rvert=\lvert\mathfrak{B}_{O_0}\rvert\cdot\lvert\mathfrak{A}(s)\rvert$
   を満たすこと（1 対 1 対応の帰結）。

### $g$ の取り方

本文の $g$ は「各 $(O,\psi)$ へ $\mathbb{Z}[x][t]$ の元を与える任意の対応」である。検証では
軌道の並び順 $i$ と全単射の並び順 $j$ から決まる決定的な元
$g(O,\psi)=t^{j+1}+(i+1)x^{j+1}+(i+j+2)$ を割り当てる（乱数を使わない。再現するため）。
零多項式にも定数にもならない形にしてあるのは、退化した状況で通ってしまうのを避けるためである。

### 主張が空でないことの確認

- $L=3$ で軌道の大きさは $1,1,3,3$ であり、大きさ 3 の軌道では $\lvert\mathfrak{B}_O\rvert=6$ である
  （すべての軌道が 1 元集合なら両辺とも 1 項どうしの比較になり、主張は自明になる）。
- その 2 つの軌道を $s$ に取ると右辺は 36 項、左辺は次数 12 の多項式である。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 軌道 $\lvert\mathcal{O}_L\rvert$ | 走らせた $s$ | 分配則を確かめた $s$ | 一歩を確かめた $(s,O_0)$ |
|---|---|---|---|---|
| 1 | 2 | 全部分集合 | 4 | 4 |
| 2 | 3 | 全部分集合 | 8 | 12 |
| 3 | 4 | 全部分集合 | 16 | 32 |
| 4 | 6 | 空集合・1 元・大きい軌道 2 つ | 8 | 40 |

$L=4$ で $s$ を全部分集合（64 個）にわたって走らせていないのは、$\mathfrak{A}(s)$ が全体で
27648 個になり多項式の積の総当たりが現実的でないためである。**この打ち切りは隠さない。**
$L\le3$ では $s$ を全部分集合にわたって走らせている。

計算はすべて $\mathbb{Z}[x][t]$ の中の厳密な多項式演算であり、浮動小数点は使っていない。

### 実行

```sh
sage sagemath/check/orbit-family-distributive/check.sage
```

### 結果

**2026-08-09 実行、すべて通過。** 出力は上表のとおり（$L=1,2,3,4$ について
出発点・分配則そのもの・一歩、および $L=3$ で主張が空でないこと）。
