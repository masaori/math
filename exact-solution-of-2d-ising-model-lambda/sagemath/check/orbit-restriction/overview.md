# SageMath Check: 軌道を保つ置換の、軌道への制限

## 対象

**対象ラベル**: `def_orbit_restriction` / `claim_orbit_restriction_bijective` /
`claim_orbit_restriction_determines`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件
  （軌道を保つ置換の、軌道への制限 $\varphi\!\restriction_{O}$）・主張 2 件
  （制限は軌道の上の全単射である・制限の全体が一致する置換は一致する）
- 併せて使う定義・主張: `def_row_configuration` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_row_permutation` / `def_permutation_sign` /
  `def_orbit_preserving_permutation` / `claim_orbit_preserving_image`

### 何を確定させるための検証か

本文は、軌道を保つ置換 $\varphi\in\mathfrak{S}^{\mathcal{O}}_L$ の各軌道 $O$ への制限
$\varphi\!\restriction_{O}$ を定め、それが $O$ の上の全単射であること、および制限の全体が
$\varphi$ を決めることを示している。これは、シフト行列の特性多項式 $\chi_U$ の和を
軌道ごとの積へ組み替えるための足場である（各軌道の因子が、その軌道の上の置換にわたる和として現れる）。

1. **定義が写像として定まること。** 任意の $\tau\in O$ で $\varphi(\tau)\in O$ であること。
   本文がこれを `claim_orbit_preserving_image` から出している段にあたる。
   **これを別に確かめる。** 下の 2 の全単射性だけを見ると、行き先が $O$ からはみ出していても
   「はみ出した先も含めた集合の上の全単射」として成り立ってしまい、定義の破れが隠れるためである。
2. `claim_orbit_restriction_bijective`。$\varphi\!\restriction_{O}$ が $O$ から $O$ への全単射であること。
   人手証明が単射性と全射性を別々に示しているので、検証も別々に確かめる。単射性は $O$ の全対、
   全射性は $O$ の各元について逆像を実際に見つける形（人手証明が $\tau_3$ を取る段）で見る。
3. `claim_orbit_restriction_determines`。任意の $O\in\mathcal{O}_L$ で
   $\varphi\!\restriction_{O}=\psi\!\restriction_{O}$ ならば $\varphi=\psi$。
   $\mathfrak{S}^{\mathcal{O}}_L$ の全対を総当たりする。**対偶の側も確かめる。**
   すなわち $\varphi\ne\psi$ ならば制限が食い違う軌道が実際に存在すること。
   含意だけを見ると、制限がすべて一致する対がそもそも同じ置換しか無い（＝仮定が空虚）場合を
   見逃すためである。

### 主張が空でないことの確認

- $L=3$ で $\mathfrak{S}^{\mathcal{O}}_L$ は $36$ 個あり、恒等置換だけではない。
  すなわち 2 と 3 の主張は自明ではない。
- $L=3$ で $\varphi\!\restriction_{O}$ が恒等写像でない場合が実際にある。
  すなわち制限が元を動かす場合が空でない。
- $L=3$ で大きさが 2 以上の軌道が実際にある。すべての軌道が 1 元集合なら制限は自明だからである。

なお $L=1$ では $S$ が恒等写像なので軌道はすべて 1 元集合であり、
$\mathfrak{S}^{\mathcal{O}}_L$ は恒等置換だけ（1 個）である。
$L=1$ を走らせているのは定義が退化した場合でも壊れないことを見るためであって、
主張の中身を確かめているのは $L\ge2$ の側である。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 置換 $\lvert\mathfrak{S}_L\rvert=(2^{L})!$ | 軌道を保つ置換 $\lvert\mathfrak{S}^{\mathcal{O}}_L\rvert$ | 軌道 $\lvert\mathcal{O}_L\rvert$ |
|---|---|---|---|---|
| 1 | 2 | 2 | 1 | 2 |
| 2 | 4 | 24 | 2 | 3 |
| 3 | 8 | 40320 | 36 | 4 |

$\mathfrak{S}^{\mathcal{O}}_L$ は $\mathfrak{S}_L$ を全列挙して定義の条件で絞って得ている。
したがって全列挙できる $L=1,2,3$ に限られる（$L=4$ では $16!$ 通りになり総当たりできない）。

**軌道ごとの置換から $\mathfrak{S}^{\mathcal{O}}_L$ を組み立てれば $L=4$ も回せるが、そうしない。**
その組み立てが成り立つこと（軌道ごとの置換の組と $\mathfrak{S}^{\mathcal{O}}_L$ が 1 対 1 に
対応すること）は次のセクションで示す主張であり、ここでそれを前提にすると検証が循環するためである。

### 計算の厳密性

有限集合の上の写像の相等の比較だけであり、数として現れるのは個数（$\mathbb{Z}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$L=1,2,3$。上の 1〜3 と「主張が空でないことの確認」） |

```
sage sagemath/check/orbit-restriction/check.sage
```
