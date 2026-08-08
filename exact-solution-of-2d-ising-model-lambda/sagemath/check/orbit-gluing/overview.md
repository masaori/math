# SageMath Check: 軌道ごとの置換の組の貼り合わせ

## 対象

**対象ラベル**: `def_orbit_permutation_family` / `def_orbit_gluing` /
`claim_orbit_gluing_bijective` / `claim_orbit_gluing_orbit_preserving` /
`claim_orbit_gluing_restriction`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 2 件
  （軌道ごとの置換の組 $\mathfrak{A}_L$・その貼り合わせ $\mathrm{gl}(\alpha)$）・主張 3 件
  （貼り合わせは全単射である・貼り合わせは軌道を保つ・貼り合わせの各軌道への制限がもとの組に一致する）
- 併せて使う定義・主張: `def_row_configuration` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_row_permutation` / `def_permutation_sign` /
  `def_orbit_preserving_permutation` / `def_orbit_restriction` /
  `claim_row_config_orbit_mem_eq` / `claim_row_config_orbit_disjoint_or_eq`

### 何を確定させるための検証か

本文は、軌道ごとに 1 つずつ与えられた全単射の組 $\alpha\in\mathfrak{A}_L$ から
$R_L$ の置換 $\mathrm{gl}(\alpha)$ を作り、それが軌道を保つ置換であること、その制限がもとの組に
戻ることを示している。前のセクション（`orbit-restriction`）の「制限の全体が置換を決めること」と
合わせて、$\mathfrak{S}^{\mathcal{O}}_L$ と $\mathfrak{A}_L$ が 1 対 1 に対応することになる。
これが、シフト行列の特性多項式 $\chi_U$ の和を軌道ごとの積へ組み替える土台である。

1. **定義が写像として定まること。** $\tau\in O(\tau)$ であり、$O(\tau)\in\mathcal{O}_L$ であり、
   $\bigl(\alpha(O(\tau))\bigr)(\tau)$ が $O(\tau)$（したがって $R_L$）に収まること。
   **これを別に確かめる。** 下の 2 の全単射性だけを見ると、値が $O(\tau)$ からはみ出していても
   $R_L$ の上の全単射としては成り立ちうるので、定義の破れが隠れるためである。
   あわせて、定義が $\tau$ の属する軌道として $O(\tau)$ を選んでいることの正当性
   （$\tau$ を含む $\mathcal{O}_L$ の元は $O(\tau)$ ただ 1 つであること）も確かめる。
2. `claim_orbit_gluing_bijective`。$\mathrm{gl}(\alpha)$ が $R_L$ の上の全単射であること。
   人手証明が単射性と全射性を別々に示しているので、検証も別々に確かめる。単射性は $R_L$ の全対、
   全射性は各行配位について逆像を実際に見つける形（人手証明が $\tau_4$ を取る段）で見る。
3. `claim_orbit_gluing_orbit_preserving`。任意の $\tau$ で $\bigl(\mathrm{gl}(\alpha)\bigr)(\tau)\in O(\tau)$。
4. `claim_orbit_gluing_restriction`。任意の $O\in\mathcal{O}_L$ で
   $\mathrm{gl}(\alpha)\!\restriction_{O}=\alpha(O)$。
5. **1 対 1 対応。** $\alpha\mapsto\mathrm{gl}(\alpha)$ が単射であり、その像が
   $\mathfrak{S}^{\mathcal{O}}_L$ に一致すること。
   **像の一致は、$\mathfrak{S}_L$ を全列挙して定義の条件で絞って得た $\mathfrak{S}^{\mathcal{O}}_L$ と
   突き合わせて確かめる。** 軌道ごとの置換から組み立てたものを $\mathfrak{S}^{\mathcal{O}}_L$ の
   定義に据えると循環するので、そうしない（前のセクションの検証 `orbit-restriction` でも
   同じ理由で全列挙から絞っている）。

### 主張が空でないことの確認

- $L=3$ で組は $36$ 個あり、恒等の組だけではない。
- $L=3$ で大きさが 2 以上の軌道が実際にある（すべて 1 元集合なら組は 1 つしかない）。
- $L=3$ で恒等でない貼り合わせが実際にある。
- $L=3$ で $|\mathfrak{A}_L|=36<40320=|\mathfrak{S}_L|$。すなわち貼り合わせは
  $\mathfrak{S}_L$ の全体を尽くさない（軌道をまたいで動かす置換は作れない）。

なお $L=1$ では $S$ が恒等写像なので軌道はすべて 1 元集合であり、組は 1 個しかない。
$L=1$ を走らせているのは定義が退化した場合でも壊れないことを見るためである。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 軌道 $\lvert\mathcal{O}_L\rvert$ | 軌道の大きさ | 組 $\lvert\mathfrak{A}_L\rvert$ | 1 対 1 対応の突き合わせ |
|---|---|---|---|---|---|
| 1 | 2 | 2 | 1, 1 | 1 | 行った（$\lvert\mathfrak{S}_L\rvert=2$） |
| 2 | 4 | 3 | 1, 1, 2 | 2 | 行った（$\lvert\mathfrak{S}_L\rvert=24$） |
| 3 | 8 | 4 | 1, 1, 3, 3 | 36 | 行った（$\lvert\mathfrak{S}_L\rvert=40320$） |
| 4 | 16 | 6 | 1, 1, 2, 4, 4, 4 | 27648 | **行っていない** |

1〜4 は組 $\alpha$ の全列挙だけで済むので $L=4$ まで走らせた。
5（1 対 1 対応）は $\mathfrak{S}_L$ の全列挙（$(2^{L})!$ 個）が要るので $L=1,2,3$ に限る
（$L=4$ では $16!$ 通りで総当たりできない）。

### 計算の厳密性

有限集合の上の写像の相等の比較だけであり、数として現れるのは個数（$\mathbb{Z}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（1〜4 は $L=1,2,3,4$、5 は $L=1,2,3$。および「主張が空でないことの確認」） |

```
sage sagemath/check/orbit-gluing/check.sage
```
