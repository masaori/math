# SageMath Check: 倍数の辺での下限への任意近接（0 < t ≤ 1 の場合）

## 対象

**対象ラベル**: `claim_open_free_energy_density_infimum_approximation_multiples_le_one`

- 実行日: 2026-08-15
- 状態: PASS（31 件）
- 帰属: 開境界正方形の値は `QQ` で厳密に計算する。単調性 $\psi^{\mathrm{op}}_{ka}\le\psi^{\mathrm{op}}_a$ は、実対数の単調性で正の有理数の整数冪の比較へ戻して厳密に検査する。下限と $\varepsilon$ を含む比較だけ `RealBallField(256)` を使う。

## 検査内容

- $t\in\{1,3/4,1/2,1/5\}$、$(a,k)\in\{(1,2),(1,3),(1,4),(2,2)\}$ の 16 組で $\psi^{\mathrm{op}}_{ka}(t)\le\psi^{\mathrm{op}}_a(t)$ を厳密検査する。
- 一辺 $1$ から $4$ の有限値集合をモデルに、最小値 $v$ を分配関数の整数冪の厳密比較で特定する。$\varepsilon\in\{1/10,1/100\}$ について $\psi^{\mathrm{op}}_a<v+\varepsilon$ を ball の分離で確かめ、モデル内の倍数 $ka$ に対する $v\le\psi^{\mathrm{op}}_{ka}$ は再び整数冪の厳密比較で検査する（15 件）。

## 範囲

無限の値集合の下限そのものは有限標本では検査できない。有限モデルは証明の三段（反例 $a$ の存在、倍数での単調性、下界性）の形を確かめるものである。Lean 具体版は下限の存在を仮定に置き、人手証明と同じ順で辿る。

## Lean

具体版・必要十分版・導出版を `lean/Ising2DLambda/ThermodynamicLimit/` と
`lean/Ising2DLambda/NecSuf/ThermodynamicLimit/` に置く（2026-08-15、`lake build` と sorry 検査で検証）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-free-energy-density-infimum-approximation-multiples/check.sage
```
