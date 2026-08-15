# SageMath Check: 開境界密度の下からの評価と下限の存在

## 対象

**対象ラベル**: `claim_open_free_energy_density_lower_bound_le_one`, `claim_open_free_energy_density_infimum_exists_le_one`, `def_real_set_lower_bound`, `def_real_set_infimum`

- 実行日: 2026-08-15
- 状態: PASS（56 件）
- 帰属: 分配関数と自然数冪の比較は `QQ` で厳密に検査する。自由エネルギー密度だけは実対数を含むため `RealBallField(256)` を使い、区間が分離していることを検査する。

## 検査内容

- $t\in\{1,3/4,1/2,1/5\}$、$L\in\{1,2,3,4\}$ で $2t^{2L(L-1)}\le Z^{\mathrm{op}}_{L,L}(t)$ と $t^{2L^2}\le2t^{2L(L-1)}$ を厳密検査する（32 件）。
- 同じ 16 組で $2\log_{\mathbb R}t\le\psi^{\mathrm{op}}_L(t)$ を ball の分離で検査する。
- 各 $t$ の有限値集合について最小値が全要素以下であり、一様下界 $2\log_{\mathbb R}t$ が全要素以下であることを検査する（8 件）。

## 範囲

無限集合へ下限を与える実数の完備性は有限標本では検査できない。本文では値集合の符号を反転し、既に宣言した「空でなく上に有界な実数集合は上限を持つ」という形だけを使って下限を構成する。

## Lean

具体版 `lean/Ising2DLambda/ThermodynamicLimit/OpenFreeEnergyDensityLowerBound.lean`・
`OpenFreeEnergyDensityInfimum.lean`、必要十分版 `NecSuf/ThermodynamicLimit/` の同名二本
（2026-08-15、`lake build` と sorry 検査 1049 件通過）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-free-energy-density-infimum/check.sage
```
