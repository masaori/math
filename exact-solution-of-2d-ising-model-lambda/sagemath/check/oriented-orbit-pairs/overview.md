# SageMath Check: またぐ転倒対の全体の個数の偶数性

## 対象

**対象ラベル**: `def_oriented_orbit_pairs` / `claim_oriented_orbit_pairs_cross_disjoint` /
`claim_cross_orbit_inversion_pairs_union` / `claim_cross_orbit_inversion_pairs_even`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件
  （最小元で向きを付けた軌道の順序対の全体 $\mathcal{D}_L$）と主張 3 件
  （$\mathcal{D}_L$ の相異なる 2 元が与える $J_\varphi$ が交わらないこと・
  $\mathrm{Inv}^{\ne}(\varphi)$ がその合併であること・$|\mathrm{Inv}^{\ne}(\varphi)|$ が偶数であること）
- 併せて使う定義・主張: `def_row_config_order` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_row_config_min` / `def_orbit_preserving_permutation` /
  `def_inversion_count` / `def_inversion_pairs` / `def_cross_orbit_inversion_pairs` /
  `def_cross_orbit_inversions` / `def_cross_orbit_ordered_pairs` /
  `def_cross_orbit_ordered_pairs_image` / `claim_cross_orbit_inversions_even`

### 何を確定させるための検証か

置換の符号を軌道ごとの符号の積へ分解するとき、軌道をまたぐ転倒対の寄与が $(-1)$ の冪に
効かないことを言う必要がある。そのために要るのが $|\mathrm{Inv}^{\ne}(\varphi)|$ の偶数性である。
軌道の対ごとの偶数性（`claim_cross_orbit_inversions_even`）を足し合わせるには、
$(O,O')$ と $(O',O)$ を 2 度数えないよう順序対の全体を半分に分けねばならない。
その分け方が $\mathcal{D}_L$ である。

1. `def_oriented_orbit_pairs`。$\mathcal{D}_L$ の元が $\mathcal{O}_L\times\mathcal{O}_L$ の元で
   あり、第 1 成分と第 2 成分が相異なること。加えて、相異なる軌道の順序対 $(O,O')$ と $(O',O)$ の
   **ちょうど一方**が $\mathcal{D}_L$ に属すること（半分に分ける道具になっていること）。
   **これを別に確かめる理由**: 下の 3 は個数の等式なので、$\mathcal{D}_L$ が多すぎても
   少なすぎても、2 倍という形の中に紛れて見逃しうる。
2. `claim_oriented_orbit_pairs_cross_disjoint`。$\mathcal{D}_L$ の相異なる 2 元が与える
   $J_\varphi$ が交わらないこと。
3. `claim_cross_orbit_inversion_pairs_union`。人手証明は**集合の等号**を示しているので、
   検証も個数ではなく集合の等号で見る。
4. `claim_cross_orbit_inversion_pairs_even`。
   $|\mathrm{Inv}^{\ne}(\varphi)|=2\sum_{(O,O')\in\mathcal{D}_L}|F(O,O')\setminus F_\varphi(O,O')|$。
   中間の和 $\sum|J_\varphi(O,O')|$ も別に確かめる（最終の等式だけを見ると、合併の段と
   対ごとの偶数性の段が両方誤っていて辻褄が合う場合を見逃す）。

### 主張が空でないことの確認（走らせた L ごとに記録する）

2026-08-09 の実行では次のとおりであった。$\mathcal{D}_L$ はどの $L$ でも空でないが、
$\mathrm{Inv}^{\ne}(\varphi)$ に中身があるのは $L=3$ だけである。すなわち $L=1,2$ の実行は
$0=2\cdot0$ を確かめているだけであり、主張の中身を見ているのは $L=3$ だけである。

| $L$ | 軌道 $\lvert\mathcal{O}_L\rvert$ | $\lvert\mathcal{D}_L\rvert$ | 軌道を保つ置換 | $\mathrm{Inv}^{\ne}(\varphi)\ne\emptyset$ の例 |
|---|---|---|---|---|
| 1 | 2 | 1 | 1 個 | 無い |
| 2 | 3 | 3 | 2 個 | 無い |
| 3 | 4 | 6 | 36 個 | ある |

（前のセクションの検証 `cross-orbit-inversions` でも、またがる転倒対に中身があるのは
$L=3$ からであった。同じ事情である。）

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| $\mathcal{D}_L$ の定義（上の 1） | $L=1,\dots,5$。置換を走らせないので軌道の全対だけで済む |
| 交わらないこと・合併・偶数性 | $L=1,2,3$ |

置換を走らせる検証を $L=3$ までに限ったのは、軌道を保つ置換の全体
$\mathfrak{S}^{\mathcal{O}}_L$ を $\mathfrak{S}_L$ の全列挙から絞って作っているためである
（$L=4$ では $16!$ 通りになる）。軌道ごとの置換から組み立てれば $L=4$ も回せるが、
その組み立てが成り立つことは前のセクションの主張なので、ここで前提にすると検証が循環する。

### 計算の厳密性

有限集合の元の比較と数え上げだけであり、数として現れるのは個数（$\mathbb{N}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$\mathcal{D}_L$ の定義・交わらないこと・合併の集合の等号・偶数性と中間の和） |

```
sage sagemath/check/oriented-orbit-pairs/check.sage
```
