# SageMath Check: 周期境界の密度の列が定める下組・周期境界の密度の下組は開境界正方形の密度の下組に含まれる（q は 1 以下）

## 対象

**対象ラベル**: `def_periodic_density_lower_set`, `claim_periodic_density_lower_set_subset_open_square_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$L\le3$、有理点 6 点、所属の証人 288 組、2016 検査。所要 10 秒程度）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda_{\mathbb{Q}}$ で閉じており、実数体も実対数も現れない）。

## 検査内容

周期境界の密度の列 $L\mapsto\Psi_L(q)$ と開境界正方形の密度の列 $L\mapsto\Psi^{\mathrm{op}}_L(q)$ を
$L\in\{1,2,3\}$ で配位の全数え上げから作る（周期境界の辺は開境界正方形の辺と $2L$ 本の境界横断辺の和。
`periodic-open-boundary-comparison-density` と同じ模型）。

- **`def_periodic_density_lower_set`**: 所属を証人 $(\varepsilon,N)$ について検査する。「$N\le L$ を満たすすべての $L$」は
  有限範囲 $N\le L\le3$ で検査する（全称そのものは証明で示す事柄であり、有限回の計算では確かめられない）。
  検査する $\mu$ は、各 $L_0$ の $\Psi_{L_0}(q)$ から素数 $2,3,5$ の係数を $-1,-\tfrac12,0,\tfrac13$ から選んだ正の
  $\varepsilon$ を引いた元で、有限範囲で所属を示せる証人 $(\varepsilon,N)$ の組だけを数える（288 組）。
- **主張の証明の中身**: 所属の証人 $(\varepsilon,N)$ をそのまま使い、$N\le L$ の各 $L$ で
  一段目 $\mu+\varepsilon\le_{\Lambda_{\mathbb{Q}}}\Psi_L(q)$（証人の性質）、
  二段目 $\Psi_L(q)\le_{\Lambda_{\mathbb{Q}}}\Psi^{\mathrm{op}}_L(q)$（`claim_periodic_open_boundary_comparison_density_le_one` の右）、
  推移律の結論 $\mu+\varepsilon\le_{\Lambda_{\mathbb{Q}}}\Psi^{\mathrm{op}}_L(q)$ を検査し、
  同じ証人で $\mu\in A^{\mathrm{op}}(q)$（所属）を検査する。

順序は `def_rational_log_order_group_order` の決定手続き（共通分母での証人の $\Lambda$ の比較）で判定する。
有理点は $\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $q$・$\mu$ についての包含の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/PeriodicDensityLowerSet.lean`（`periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one`）、
必要十分版 `NecSuf/ThermodynamicLimit/PeriodicDensityLowerSetSubsetOpenSquare.lean`
（`lowerSetOfSequence_subset_of_pointwise_le_necSuf`。使うのは推移律と項ごとの比較だけ）、
導出版 `PeriodicDensityLowerSetFromNecSuf.lean`。

## 実行方法

```sh
sage sagemath/check/periodic-density-lower-set-subset-open-square/check.sage
```
