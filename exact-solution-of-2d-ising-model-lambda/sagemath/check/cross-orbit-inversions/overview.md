# SageMath Check: 2 つの軌道にまたがる転倒対

## 対象

**対象ラベル**: `def_cross_orbit_ordered_pairs` / `def_cross_orbit_ordered_pairs_image` /
`def_cross_orbit_inversions` / `claim_cross_orbit_ordered_card` /
`claim_cross_orbit_inversions_even`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 3 件
  （$F(O,O')$・$F_\varphi(O,O')$・$J_\varphi(O,O')$）と主張 2 件
  （軌道を保つ置換はまたがる順序づけられた対の個数を変えない・
  2 つの相異なる軌道にまたがる転倒対の個数は偶数である）
- 併せて使う定義・主張: `def_row_configuration` / `def_row_config_order` /
  `def_row_permutation` / `def_inversion_count` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_preserving_permutation` /
  `claim_row_config_order_linear` / `claim_row_config_orbit_disjoint_or_eq` /
  `claim_orbit_preserving_image`

### 何を確定させるための検証か

置換の符号は転倒数 $\mathrm{inv}(\varphi)$ で定まる。軌道を保つ置換について符号を軌道ごとの
符号の積へ分解するには、転倒対を「同じ軌道に属する対」と「異なる軌道にまたがる対」へ分け、
**またがる対の寄与が偶数である**（したがって $(-1)$ の冪に効かない）ことが要る。
このセクションはその偶数性を示す。次のセクションで転倒数の分解と符号の積表示を書く。

1. **定義が実装と合っていること。** $F(O,O')$ と $F_\varphi(O,O')$ が $O\times O'$ の、
   $J_\varphi(O,O')$ と $F(O,O')$ が $P_L$ の部分集合であること。
   **これを別に確かめる。** 下の 2・3 は個数の等式なので、集合の取り違え（たとえば
   第 1 成分と第 2 成分の入れ替え）が個数の一致に隠れて検出できないためである。
2. `claim_cross_orbit_ordered_card`。$|F_\varphi(O,O')|=|F(O,O')|$。
   人手証明は写像 $\Upsilon(\tau,\tau')=(\varphi(\tau),\varphi(\tau'))$ が
   $F_\varphi(O,O')$ から $F(O,O')$ への全単射であることで示すので、個数だけでなく
   **$\Upsilon$ が実際にその対応を与えること**（値が $O\times O'$ に収まること・単射であること・
   $F_\varphi$ の像がちょうど $F$ であること）も確かめる。
3. `claim_cross_orbit_inversions_even`。$O\ne O'$ のとき
   $|J_\varphi(O,O')|=2\,|F(O,O')\setminus F_\varphi(O,O')|$ であり、とくに偶数であること。
   人手証明の中間段（$J_\varphi=J_1\sqcup J_2$、$J_1=F\setminus F_\varphi$、
   $\mathrm{sw}$ が $J_2$ を $F_\varphi\setminus F$ の上へ写すこと、
   $|F\setminus F_\varphi|=|F_\varphi\setminus F|$）も**別々に**確かめる。
   最終の等式だけを見ると、2 つの中間段が両方誤っていて辻褄が合う場合を見逃す。
4. **$O=O'$ では成り立つとは限らないこと。** 本文は軌道が相異なることを仮定しており、
   その仮定が効いていることの裏取りとして、$|J_\varphi(O,O)|$ が奇数になる例が実際にあることを見る。

### 主張が空でないことの確認

- $L=3$ で $|J_\varphi(O,O')|>0$ となる $\varphi$ と軌道の対が実際にある
  （つねに空なら偶数性は自明で何も言っていない）。
- $L=2,3$ で $|J_\varphi(O,O)|$ が奇数になる例がある（$O\ne O'$ の仮定が効いている）。

**$L=1,2$ では偶数性の主張が空虚な場合しか現れない。** 実行すると、$L=1,2$ では
相異なる軌道の対と軌道を保つ置換をすべて走らせても $|J_\varphi(O,O')|=0$ であり、
$|F(O,O')\setminus F_\varphi(O,O')|=0$ でもあるので、確かめている等式は $0=2\cdot0$ である。
すなわち**偶数性について中身のある検証をしているのは $L=3$ だけ**である。
$L=1,2$ を走らせる意味は、定義の部分集合性と $|F_\varphi|=|F|$（こちらは $L=1,2$ でも
空虚ではない）を退化した場合でも確かめること、および $O=O'$ で奇数になる例（$L=2$）を
拾うことにある。

なお $L=1$ では巡回シフトが恒等写像なので軌道はすべて 1 元集合であり、
軌道を保つ置換は恒等置換だけである。$L=1$ を走らせているのは定義が退化した場合でも
壊れないことを見るためである。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 軌道 $\lvert\mathcal{O}_L\rvert$ | 軌道を保つ置換 $\lvert\mathfrak{S}^{\mathcal{O}}_L\rvert$ | 軌道の対 |
|---|---|---|---|---|
| 1 | 2 | 2 | 1 | 4 |
| 2 | 4 | 3 | 2 | 9 |
| 3 | 8 | 4 | 36 | 16 |
| 4 | 16 | 6 | — | **走らせていない** |

$\mathfrak{S}^{\mathcal{O}}_L$ は $\mathfrak{S}_L$ を全列挙して
`def_orbit_preserving_permutation` の条件で絞って作る。軌道ごとの置換から組み立てると、
その組み立てが前のセクションの主張（`claim_orbit_gluing_bijective` ほか）になっていて
検証が循環するので、そうしない。全列挙が $(2^{L})!$ 個なので $L=4$（$16!$ 通り）は走らせられない。

### 計算の厳密性

有限集合の元の比較と数え上げだけであり、数として現れるのは個数（$\mathbb{N}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,2,3$。および「主張が空でないことの確認」と $O=O'$ の裏取り） |

```
sage sagemath/check/cross-orbit-inversions/check.sage
```
