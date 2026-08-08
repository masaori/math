# SageMath Check: 行配位の最小周期

## 対象

**対象ラベル**: `def_row_config_shift_minimal_period` / `claim_row_config_shift_iterate_add` /
`claim_row_config_shift_period_divides` / `claim_row_config_minimal_period_divides_L`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件（最小周期）と主張 3 件
- 併せて使う定義: `def_lattice` / `def_row_configuration` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `claim_row_config_shift_period`

### 何を確定させるための検証か

本文は、行配位 $\tau$ をもとへ戻す反復の回数の全体 $K(\tau)$ の最小元として最小周期 $e(\tau)$ を定め、
$S^{[k]}(\tau)=\tau$ と「$e(\tau)$ が $k$ を割り切る」が同値であること、および $e(\tau)$ が $L$ を
割り切ることを示している。これは次のセクションで特性多項式を軌道ごとの因子へ分解し、
その根が 1 の $L$ 乗根であることを言うための足場である。

1. `def_row_config_shift_minimal_period`。$K(\tau)$ が $L$ を含むこと（空でないこと。
   最小元が取れる根拠）、その最小元 $e(\tau)$ が $S^{[e(\tau)]}(\tau)=\tau$ を満たすこと、
   そして $1\le k<e(\tau)$ では $S^{[k]}(\tau)\ne\tau$ であること。
2. `claim_row_config_shift_iterate_add`。$S^{[a+b]}(\tau)=S^{[a]}(S^{[b]}(\tau))$。
   左辺は $a+b$ 回の反復を直接作り、右辺は 2 段に分けて作る（作り方が独立）。
3. `claim_row_config_shift_period_divides`。$S^{[k]}(\tau)=\tau\iff e(\tau)\mid k$。
   **両方向を確かめる。** 片方向だけでは、$e$ を過大に取る誤りと過小に取る誤りの
   どちらかが隠れる（過大なら「割り切る $\Rightarrow$ 戻る」が破れ、過小なら逆が破れる）。
4. `claim_row_config_minimal_period_divides_L`。$e(\tau)$ は $L$ を割り切る。
   あわせて $e(\tau)$ を「$L$ の約数 $d$ のうち $S^{[d]}(\tau)=\tau$ となる最小のもの」として
   作り直し、$1$ の探索（$1$ から順に走らせるもの）と一致することを見る。作り方が独立なので、
   $L$ の約数でない周期を取り違えて拾う誤りを検出できる。

### 主張が空でないことの確認

- $L=4$ で最小周期は $1,2,4$ のすべてを実際に取る。すなわち 4 は「$e(\tau)=L$」という
  自明な理由で成り立っているのではない。
- $L=3$ で、走らせた $k$ の範囲に $S^{[k]}(\tau)=\tau$ となる $k$ とならない $k$ の両方が現れる
  （同値が片側だけで自明に成り立っているのではない）。

なお $L=1$ では行配位が $S$ で動かないのですべての最小周期が $1$ であり、主張は自明に成り立つ。
$L=1$ を走らせているのは定義が退化した場合でも壊れないことを見るためであって、
主張の中身を確かめているのは $L\ge2$ の側である。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 反復の回数 $a,b$ | 同値を見る $k$ |
|---|---|---|---|
| 1 | 2 | $0\le a,b\le 2$ | $0\le k\le 3$ |
| 2 | 4 | $0\le a,b\le 4$ | $0\le k\le 6$ |
| 3 | 8 | $0\le a,b\le 6$ | $0\le k\le 9$ |
| 4 | 16 | $0\le a,b\le 8$ | $0\le k\le 12$ |
| 5 | 32 | $0\le a,b\le 10$ | $0\le k\le 15$ |
| 6 | 64 | $0\le a,b\le 12$ | $0\le k\le 18$ |

各 $L$ について行配位は**総当たり**である。$L$ の全体と $k$ の全体は無限集合なので、
$L$ は 6 つの値に、$k$ は上の範囲に限っている。$L=6$ を入れたのは、約数が
$1,2,3,6$ と複数あり、最小周期が $L$ の真の約数になる場合が豊富に現れるためである。

### 計算の厳密性

すべて `ZZ` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,\dots,6$。上の 1〜4 と「主張が空でないことの確認」） |

```
sage sagemath/check/row-shift-minimal-period/check.sage
```
