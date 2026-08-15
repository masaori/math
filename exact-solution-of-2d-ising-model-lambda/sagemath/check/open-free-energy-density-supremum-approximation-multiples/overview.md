# SageMath Check: 倍数の辺での上限への任意近接（1 ≤ t の場合）

## 対象

**対象ラベル**: `claim_open_free_energy_density_supremum_approximation_multiples_one_le`

- 実行日: 2026-08-15
- 状態: PASS（30 件）
- 帰属: 開境界正方形の値は `QQ` で厳密に計算する。証明の第二段の単調性 $\psi^{\mathrm{op}}_a\le\psi^{\mathrm{op}}_{ka}$ は、実対数の単調性で指数側へ戻した有理数の不等式 $Z_a^{(ka)^2}\le Z_{ka}^{a^2}$ として厳密に検査する。上限と $\varepsilon$ を含む比較だけ `RealBallField(256)` を使う（実対数が要るため）。

## 検査内容

- $t\in\{1,3/2,2,5\}$、$(a,k)\in\{(1,2),(1,3),(1,4),(2,2)\}$ の 16 組で $\psi^{\mathrm{op}}_a(t)\le\psi^{\mathrm{op}}_{ka}(t)$ を厳密検査する。
- 一辺 $1$ から $4$ の有限値集合をモデルに、最大値 $u$ を分配関数の整数冪の厳密比較で特定する。$\varepsilon\in\{1/10,1/100\}$ について $u-\varepsilon<\psi^{\mathrm{op}}_a$ を ball の分離で確かめ、モデル内の倍数 $ka$ に対する $\psi^{\mathrm{op}}_{ka}\le u$ は再び整数冪の厳密比較で検査する（14 件）。

## 範囲

無限の値集合の上限そのものは有限標本では検査できない。有限モデルは証明の三段（反例 $a$ の存在、倍数での単調性、上界性）の形を確かめるものである。Lean 具体版は上限の存在を仮定に置き、人手証明と同じ順で辿る。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-free-energy-density-supremum-approximation-multiples/check.sage
```
