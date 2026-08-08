# SageMath Check: 行配位の軌道と、その元の個数

## 対象

**対象ラベル**: `claim_row_config_shift_iterate_injective` / `def_row_config_orbit` /
`claim_row_config_orbit_card`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件（反復の単射性）・
  定義 1 件（軌道）・主張 1 件（軌道の元の個数）
- 併せて使う定義・主張: `def_lattice` / `def_row_configuration` / `def_column_translation` /
  `def_row_config_shift` / `claim_row_config_shift_bijective` / `def_row_config_shift_iterate` /
  `claim_row_config_shift_period` / `def_row_config_shift_minimal_period` /
  `claim_row_config_shift_iterate_add` / `claim_row_config_shift_period_divides`

### 何を確定させるための検証か

本文は、行配位 $\tau$ から巡回シフトの反復で到達できる行配位の全体 $O(\tau)$ を定め、
$k\mapsto S^{[k]}(\tau)$ が $\{k\in\mathbb{N}\mid k<e(\tau)\}$ から $O(\tau)$ への全単射であることから
$|O(\tau)|=e(\tau)$ を示している。これは次のセクションでシフト行列の特性多項式を軌道ごとの因子
$t^{|O(\tau)|}-1$ の積へ分解するための足場である。

1. `claim_row_config_shift_iterate_injective`。$S^{[k]}$ が単射であること。
   行配位を総当たりし、行き先が一致するのは出発点が一致するときだけであることを見る。
2. `def_row_config_orbit`。$O(\tau)$ が $\tau$ を含むこと（$k=0$ の場合）、および $S$ で閉じていること。
   後者は本文が主張していることではないが、「軌道」という語が意味をなす形になっているかの裏取りである。
3. `claim_row_config_orbit_card`。$|O(\tau)|=e(\tau)$。
   **最終の個数だけを見ない。** 人手証明の中身、すなわち写像 $\eta_\tau:J(\tau)\to O(\tau)$ の
   単射性と全射性を別々に確かめる。個数だけを見ると、単射性と全射性の両方が誤っていて
   個数がたまたま一致する場合を見逃す。
   さらに $O(\tau)$ を「反復を $e(\tau)-1$ 回まで集めたもの」ではなく「$S$ で閉じるまで
   飽和させたもの」として独立に作り直し、一致を見る。作り方が独立なので、反復の範囲の
   取り違え（$0\le k\le L-1$ と $1\le k\le L$ など）を検出できる。
   あわせて、次のセクションで使う形（$|O(\tau)|$ が $L$ を割り切ること）も見ている。

### 主張が空でないことの確認

- $L=4$ で $|O(\tau)|$ は $1,2,4$ のすべてを実際に取る。すなわち軌道の大きさがつねに $L$ という
  自明な理由で成り立っているのではない。
- $L=4$ で $S^{[k]}\ne\mathrm{id}_{R_L}$ となる $k$（$1\le k<L$）が実際にある。すなわち
  単射性の主張が $k=0$ の場合だけで自明に済んでいるのではない。

なお $L=1$ では行配位が $S$ で動かないのですべての軌道が 1 元集合であり、主張は自明に成り立つ。
$L=1$ を走らせているのは定義が退化した場合でも壊れないことを見るためであって、
主張の中身を確かめているのは $L\ge2$ の側である。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 単射性を見る反復の回数 $k$ |
|---|---|---|
| 1 | 2 | $0\le k\le 2$ |
| 2 | 4 | $0\le k\le 4$ |
| 3 | 8 | $0\le k\le 6$ |
| 4 | 16 | $0\le k\le 8$ |
| 5 | 32 | $0\le k\le 10$ |
| 6 | 64 | $0\le k\le 12$ |

各 $L$ について行配位は**総当たり**であり、軌道と個数についての検証（上の 2・3）は
反復の範囲に依存しない（$e(\tau)$ と $L$ から決まる範囲を走る）。$L$ の全体と $k$ の全体は
無限集合なので、$L$ は 6 つの値に、単射性を見る $k$ は上の範囲に限っている。
$L=6$ を入れたのは、約数が $1,2,3,6$ と複数あり、軌道の大きさが $L$ の真の約数になる場合が
豊富に現れるためである。

### 計算の厳密性

すべて `ZZ` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,\dots,6$。上の 1〜3 と「主張が空でないことの確認」） |

```
sage sagemath/check/row-shift-orbit/check.sage
```
