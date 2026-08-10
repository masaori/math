# SageMath Check: 転倒数の軌道ごとの分解

## 対象

**対象ラベル**: `def_inversion_pairs` / `def_orbit_inversion_count` /
`def_cross_orbit_inversion_pairs` / `claim_orbit_inner_inversion_pairs` /
`claim_inversion_count_orbit_decomposition`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 3 件
  （転倒対の全体 $\mathrm{Inv}(\varphi)$・軌道の上の全単射の転倒数 $\mathrm{inv}_O$・
  またぐ転倒対の全体 $\mathrm{Inv}^{\ne}(\varphi)$）と主張 2 件
  （1 つの軌道の中の転倒対の個数は制限の転倒数である・
  転倒数は軌道ごとの転倒数の和とまたぐ転倒対の個数の和である）
- 併せて使う定義・主張: `def_row_configuration` / `def_row_config_order` /
  `def_row_permutation` / `def_inversion_count` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_preserving_permutation` / `def_orbit_restriction` /
  `def_cross_orbit_ordered_pairs` / `def_cross_orbit_inversions` /
  `claim_row_config_orbit_mem_eq` / `claim_row_config_orbit_partition`

### 何を確定させるための検証か

置換の符号は転倒数で定まる。符号を軌道ごとの符号の積へ分解するには、まず転倒数そのものを
「同じ軌道の中に収まる転倒対」と「2 つの軌道にまたがる転倒対」へ分け、前者が軌道の上の
制限の転倒数になっていることを言う必要がある。このセクションはその分解を示す。
またぐ側の個数が偶数であること（したがって符号に効かないこと）は次のセクションで扱う。

1. **定義が実装と合っていること。** $\mathrm{Inv}(\varphi)$ が $P_L$ の、
   $\mathrm{Inv}^{\ne}(\varphi)$ が $\mathrm{Inv}(\varphi)$ の、軌道の中の転倒対が
   $F(O,O)$ の部分集合であること。**これを別に確かめる。** 下の 2・3 は個数の等式なので、
   集合の取り違えが個数の一致に隠れて検出できないためである。
2. `claim_orbit_inner_inversion_pairs`。人手証明は**集合の等号**を示し、個数はそこから取る。
   したがって検証も個数ではなく集合そのものの一致を見る。個数だけを見ると、
   両辺が違う集合であって個数だけ一致する場合を見逃す。
3. `claim_inversion_count_orbit_decomposition`。
   $\mathrm{inv}(\varphi)=\sum_{O}\mathrm{inv}_O(\varphi\!\restriction_O)+|\mathrm{Inv}^{\ne}(\varphi)|$。
   人手証明の中間段（Step 1 の $\mathrm{Inv}=\mathrm{Inv}^{=}\sqcup\mathrm{Inv}^{\ne}$、
   Step 2 の $\mathrm{Inv}^{=}=\bigsqcup_O A(O)$、および $A(O)$ たちが互いに素であること）も
   **別々に**確かめる。最終の等式だけを見ると、2 つの中間段が両方誤っていて辻褄が合う場合を見逃す。
4. **次のセクションへの足場。** $\mathrm{Inv}^{\ne}(\varphi)$ が、前のセクションの
   $J_\varphi(O,O')$ を相異なる軌道の非順序対にわたって集めたものと一致すること。
   次のセクションはこの一致を使って $|\mathrm{Inv}^{\ne}(\varphi)|$ の偶数性を出す。
   **これは検証であって証明ではない。**

### 主張が空でないことの確認（走らせた L ごとに記録する）

等式の両側の項がつねに 0 なら、確かめているのは $0=0+0$ であって何も言っていない。
そこで実行のたびに、その $L$ で $\mathrm{Inv}^{\ne}(\varphi)$ が空でない例があるか、
$\mathrm{inv}_O(\varphi\!\restriction_O)$ が 0 でない例があるかを出力する。
2026-08-09 の実行での結果は次のとおりである。

| $L$ | $\mathrm{Inv}^{\ne}$ が空でない例 | $\mathrm{inv}_O$ が 0 でない例 |
|---|---|---|
| 1 | 無い | 無い |
| 2 | 無い | ある |
| 3 | ある | ある |

すなわち**両方の項に中身がある形で分解を確かめているのは $L=3$ だけ**である。
$L=1$ は両側が 0 で、$L=2$ は軌道ごとの項だけに中身がある。
$L=1,2$ を走らせる意味は、定義の部分集合性と集合の等号（こちらは空虚な場合でも
取り違えを検出する）を退化した場合でも確かめることにある。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 軌道 $\lvert\mathcal{O}_L\rvert$ | 軌道を保つ置換 $\lvert\mathfrak{S}^{\mathcal{O}}_L\rvert$ |
|---|---|---|---|
| 1 | 2 | 2 | 1 |
| 2 | 4 | 3 | 2 |
| 3 | 8 | 4 | 36 |
| 4 | 16 | 6 | **走らせていない** |

$\mathfrak{S}^{\mathcal{O}}_L$ は $\mathfrak{S}_L$ を全列挙して
`def_orbit_preserving_permutation` の条件で絞って作る。軌道ごとの置換から組み立てると、
その組み立てが前のセクションの主張になっていて検証が循環するので、そうしない。
全列挙が $(2^{L})!$ 個なので $L=4$（$16!$ 通り）は走らせられない。

### 計算の厳密性

有限集合の元の比較と数え上げだけであり、数として現れるのは個数（$\mathbb{N}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,2,3$。中間段の分割・互いに素であること・空でないことの記録を含む） |

```
sage sagemath/check/inversion-orbit-decomposition/check.sage
```
