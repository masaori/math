# SageMath Check: 軌道による行配位の全体の分割

## 対象

**対象ラベル**: `claim_row_config_orbit_mem_eq` / `claim_row_config_orbit_disjoint_or_eq` /
`def_row_config_orbit_set` / `claim_row_config_orbit_partition`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 2 件
  （軌道の元の軌道はもとの軌道に等しい・2 つの軌道は一致するか互いに素である）・
  定義 1 件（軌道の全体 $\mathcal{O}_L$）・主張 1 件（$\mathcal{O}_L$ は $R_L$ の分割である）
- 併せて使う定義・主張: `def_lattice` / `def_row_configuration` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `claim_row_config_shift_period` /
  `def_row_config_shift_minimal_period` / `claim_row_config_shift_iterate_add` /
  `claim_row_config_shift_period_divides` / `def_row_config_orbit`

### 何を確定させるための検証か

本文は、行配位の軌道 $O(\tau)$ が「一致するか交わらないか」のいずれかであることを示し、
軌道の全体 $\mathcal{O}_L$ が $R_L$ の分割であることを結論している。これは次のセクションで
シフト行列の特性多項式を軌道ごとの因子 $t^{|O|}-1$ の積へ分解するための足場である
（行列の添字集合が軌道たちへ分かれることが、行列式を軌道ごとに分けて計算できることの根拠になる）。

1. `claim_row_config_orbit_mem_eq`。$\tau'\in O(\tau)$ ならば $O(\tau')=O(\tau)$。
   仮定を満たす対の全体はちょうど「$\tau$ とその軌道の各元」の対なので、これを総当たりする。
   **最終の等式だけを見ない。** 人手証明の中身、すなわち
   (a) 包含の補題「$\tau_2\in O(\tau_1)$ ならば $O(\tau_2)\subset O(\tau_1)$」（両向きに当てる形で使う）と、
   (b) 人手証明が $\tau\in O(\tau')$ を出すのに使った具体的な反復の回数 $k_0=(e(\tau)-1)\,m$ が
   ほんとうに $\tau$ へ戻すことを、別々に確かめる。
   最終の等式だけを見ると、$k_0$ の取り方が誤っていても（別の回数で戻れば）等式は成り立ち、誤りが隠れる。
2. `claim_row_config_orbit_disjoint_or_eq`。$O(\tau_1)\cap O(\tau_2)\ne\emptyset$ ならば
   $O(\tau_1)=O(\tau_2)$。行配位の全対を総当たりする。
3. `def_row_config_orbit_set` と `claim_row_config_orbit_partition`。軌道の全体 $\mathcal{O}_L$ を作り、
   分割の 3 条件（どの元も空でない・相異なる 2 元は互いに素・合併が $R_L$）を確かめる。
   あわせて元の個数の和が $|R_L|=2^{L}$ に等しいことも見る（次のセクションで特性多項式の
   次数を数えるときに使う形）。$\mathcal{O}_L$ を集合として作っているので、同じ軌道を 2 度数えない。

### 主張が空でないことの確認

- $L=4$ で $|\mathcal{O}_L|=6<16=|R_L|$ である。すなわち相異なる行配位が同じ軌道を与える場合が
  実際にあり、$\mathcal{O}_L$ を集合として取ること（同じ集合を 2 度数えないこと）が効いている。
- $L=4$ で、一致する軌道の対（相異なる $\tau_1\ne\tau_2$ で $O(\tau_1)=O(\tau_2)$）と、
  交わらない軌道の対の両方が実際にある。すなわち主張「一致するか互いに素」の 2 つの場合が
  どちらも空でない。

なお $L=1$ では行配位が $S$ で動かないのですべての軌道が 1 元集合であり、分割は自明に成り立つ。
$L=1$ を走らせているのは定義が退化した場合でも壊れないことを見るためであって、
主張の中身を確かめているのは $L\ge2$ の側である。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 軌道の全体 $\lvert\mathcal{O}_L\rvert$ |
|---|---|---|
| 1 | 2 | 2 |
| 2 | 4 | 3 |
| 3 | 8 | 4 |
| 4 | 16 | 6 |
| 5 | 32 | 8 |
| 6 | 64 | 14 |

各 $L$ について行配位は**総当たり**であり、互いに素であることの検証は全対（$2^{L}\times2^{L}$ 通り）を
走っている。$L$ の全体は無限集合なので、$L$ は 6 つの値に限っている。
$L=6$ を入れたのは、約数が $1,2,3,6$ と複数あり、大きさの異なる軌道が豊富に現れるためである。

### 計算の厳密性

すべて `ZZ` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,\dots,6$。上の 1〜3 と「主張が空でないことの確認」） |

```
sage sagemath/check/row-shift-orbit-partition/check.sage
```
