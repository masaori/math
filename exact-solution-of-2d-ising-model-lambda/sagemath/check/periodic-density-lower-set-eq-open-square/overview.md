# SageMath Check: 周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）

## 対象

**対象ラベル**: `claim_periodic_density_lower_set_eq_open_square_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$L\le3$、有理点 6 点、$A^{\mathrm{per}}$ の証人 2244 組、$A^{\mathrm{op}}$ の証人 3876 組（うち $N'\le3$ が 2137 組）、4387 検査。所要 12 秒程度）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda_{\mathbb{Q}}$ で閉じており、実数体も実対数も現れない）。

## 検査内容

周期境界の密度の列 $L\mapsto\Psi_L(q)$ と開境界正方形の密度の列 $L\mapsto\Psi^{\mathrm{op}}_L(q)$ を
$L\in\{1,2,3\}$ で配位の全数え上げから作る（`periodic-open-boundary-comparison-density` と同じ模型）。
集合の等号 $A^{\mathrm{per}}(q)=A^{\mathrm{op}}(q)$ を外延性（両向きの所属）で検査する。
候補 $\mu$ は、各 $L_0$ の $\Psi_{L_0}(q)$・$\Psi^{\mathrm{op}}_{L_0}(q)$ から素数 $2,3,5$ の係数を
$-1,-\tfrac12,0,\tfrac13,2$ から選んだ正の $\varepsilon$ を引いた元。

- **一方の包含**（`claim_periodic_density_lower_set_subset_open_square_le_one`）: 有限範囲 $N\le L\le3$ で
  $\mu\in A^{\mathrm{per}}(q)$ を示せる証人 $(\varepsilon,N)$ があるとき、同じ証人で $\mu\in A^{\mathrm{op}}(q)$。
- **逆の包含**（`claim_open_square_density_lower_set_subset_periodic_le_one`）: 有限範囲で
  $\mu\in A^{\mathrm{op}}(q)$ を示せる証人 $(\varepsilon,N)$ があるとき、証人 $(\tfrac12\cdot\varepsilon,\ N+n)$
  （$n$ は Archimedes 性の倍率を有限探索で取ったもの）で $\mu\in A^{\mathrm{per}}(q)$。
  密度の列は $L\le3$ までしか作れないので、$N+n\le3$ の証人だけを数える。

「$N\le L$ を満たすすべての $L$」は有限範囲で検査する（全称そのものは証明で示す事柄であり、有限回の計算では
確かめられない）。順序は `def_rational_log_order_group_order` の決定手続きで判定する。
有理点は $\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $q$・$\mu$ についての集合の等号の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/PeriodicDensityLowerSetEqOpenSquare.lean`（`periodicDensityLowerSet_eq_openSquareDensityLowerSet_of_le_one`。
両包含と外延性）、必要十分版 `NecSuf/ThermodynamicLimit/PeriodicDensityLowerSetEqOpenSquare.lean`
（`lowerSetOfSequence_eq_of_pointwise_le_and_eventually_le_add_error_necSuf`。仮定は二つの包含の必要十分版の仮定の和集合）、
導出版 `PeriodicDensityLowerSetEqOpenSquareFromNecSuf.lean`。

## 実行方法

```sh
sage sagemath/check/periodic-density-lower-set-eq-open-square/check.sage
```
