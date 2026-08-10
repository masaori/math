# SageMath Check: 軌道の上の全単射の符号は合成について乗法的である

## 対象

**対象ラベル**: `claim_orbit_permutation_sign_mul`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
  （$\mathrm{sgn}_{O}(\psi_1\circ\psi_2)=\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)$）
- 併せて使う定義・主張: `def_row_config_order` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_bijection_set` / `def_cross_orbit_ordered_pairs` /
  `def_orbit_inversion_count` / `def_orbit_permutation_sign` / `claim_row_config_order_linear` /
  `claim_orbit_permutation_sign_values`

### 何を確定させるための検証か

軌道の上の巡回シフトの制限の符号が $(-1)^{\lvert O\rvert-1}$ であることは、その制限が
$\lvert O\rvert-1$ 個の互換の合成であること（`claim_orbit_transposition_composite_is_shift`）と、
互換の符号が $-1$ であること（`claim_orbit_transposition_sign`）から出る。
その 2 つを繋ぐのが、この主張（合成についての乗法性）である。

確かめるのは次の 8 つである。人手証明の段ごとに別々に見る
（最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す）。

1. 準備の第一。$\psi_1\circ\psi_2$ が $O$ から $O$ への全単射であること。
2. 準備の第二。$\mathrm{srt}_{\psi_2}$ が写像として定まること。すなわち
   $\psi_2(\tau)\prec\psi_2(\tau')$ と $\psi_2(\tau')\prec\psi_2(\tau)$ の**ちょうど一方**が
   成り立ち、像が $F(O,O)$ に入ること。**これを別に見る理由**: ここが三分律の効いている
   2 か所のうちの 1 つであり、ここが崩れると写像そのものが作れない。
3. 準備の第三。$\mathrm{srt}_{\psi_2^{-1}}$ が $\mathrm{srt}_{\psi_2}$ の逆写像であること
   （両向きの合成が恒等写像であること）。
4. $|A|=\mathrm{inv}_{O}(\psi_1\circ\psi_2)$、$|B|=\mathrm{inv}_{O}(\psi_2)$、
   $|C|=\mathrm{inv}_{O}(\psi_1)$ であること。$C$ は $\mathrm{srt}_{\psi_2}$ による逆像として
   作るので、ここで全単射性が効く。
5. 各対について $A,B,C$ のうち属するものの個数が偶数であること。あわせて
   $f_A\cdot f_C\cdot f_B=1$ を見る。
6. $\mathrm{sgn}_{O}(\psi_1\circ\psi_2)\cdot\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)=1$。
7. 結論 $\mathrm{sgn}_{O}(\psi_1\circ\psi_2)=\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)$。
8. 主張が空でないこと（下記）。

### 主張が空でないことの確認（走らせた L ごとに記録する）

2026-08-10 の実行では次のとおりであった。合成の符号が $-1$ になる例は
$\lvert O\rvert\ge2$ の軌道があるところで現れる。

| $L$ | 軌道の個数 | 走らせた組の個数 | 軌道の大きさ | 合成の符号が $-1$ の例 |
|---|---|---|---|---|
| 1 | 2 | 2 | 1 | 無い |
| 2 | 3 | 6 | 1, 2 | ある |
| 3 | 4 | 74 | 1, 3 | ある |
| 4 | 6 | 1734 | 1, 2, 4 | ある |
| 5 | 8 | 86402 | 1, 5 | ある |
| 6 | 14 | 14478 | 1, 2, 3, 6 | ある |

$L=1$ では軌道がどちらも 1 元なので、両辺が $+1$ の場合しか見ていない。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 乗法性と上の 7 段 | $L=1,\dots,5$ は各軌道 $O$ について $\mathfrak{B}_{O}\times\mathfrak{B}_{O}$ を全列挙。$L=6$ は $\lvert O\rvert=6$ の軌道で $\lvert\mathfrak{B}_{O}\rvert=720$、対が 518400 個になるので、$\mathfrak{B}_{O}$ を並べた列の**先頭 40 個どうしの対に絞った**（1600 個） |

$L=6$ の絞り込みは計算量による打ち切りであり、隠さずここに書く。$\lvert O\rvert\le3$ の軌道は
$L=6$ でも全列挙している。$R_L$ の上の置換の全体（$(2^L)!$ 通り）は、この主張が軌道の上の
全単射についてのものなので列挙していない。

### 計算の厳密性

有限集合の元の比較と数え上げ、および整数 $-1$ の冪だけである。数として現れるのは
個数（$\mathbb{N}$ の元）と符号（$\mathbb{Z}$ の元）だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。所要 3 分 35 秒） |

```
sage sagemath/check/orbit-permutation-sign-mul/check.sage
```
