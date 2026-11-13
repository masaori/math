/-
# 行列の二重の有限和は和の順序を入れ替えても等しい（必要十分版）

対応する人手証明のラベル: `finite_double_sum_of_matrices_interchange`
具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteDoubleSumOfMatricesInterchange.lean` の
`finite_double_sum_of_matrices_interchange`（具体版をこのファイルの系として導くのは、同じフォルダの
`ClaimFiniteDoubleSumOfMatricesInterchangeFromNecSuf.lean`）。

人手の成分 `ℂ` を、加法が結合則・交換則と零を持つ集合 `R`（`AddCommMonoid`）に置き換える。

## 何が効いているか / 効いていないか

| 人手の段 | 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- | --- |
| 成分の鎖の 1・2・4・5 行（`finite_sum_of_matrices_entrywise`） | `Matrix.sum_apply` | 同じ（`Matrix.sum_apply`） | 行列の和は成分ごと |
| 成分の鎖の 3 行（ℂ の有限和の順序交換） | `Finset.sum_comm` | `finite_double_sum_interchange'`（`Ising2D/NecSuf/FiniteDoubleSumInterchange.lean`。外側の項の数の帰納法による自前の証明） | 加法の結合則・交換則 |
| 「全ての成分が一致し、主張を得る」 | `Matrix.ext` | 同じ | — |

- 3 段目は、具体版では人手が名前だけで引く順序交換に合わせて mathlib の `Finset.sum_comm` の 1 段、必要十分版では
  何が効いているかを示すため自前の証明 `finite_double_sum_interchange'` の 1 段である。どちらも同じ 1 段（順序交換）で、
  証明の手順は同じである。

- **効いているのは、成分の加法の結合則と交換則だけである**（3 行目の順序交換）。零は有限和 `Finset.sum` の定義が要求するだけで、
  人手の `r, s ≥ 1` の和では効いていない（`FiniteDoubleSumInterchange.lean` の同じ注意）。
- **効いていないもの**: 成分の乗法・加法の逆元、`ℂ` であること、行と列の添字の有限性。
- 結合則・交換則が削れないことは、人手の和の定義（左から足す和）で `r = s = 2`、`1 × 1` の行列で見る
  （`Finset.sum` は結合則・交換則の無い加法では定義できないので、Lean の主張の形のままでは述べられない）。両辺は
  `(X_{11} + X_{12}) + (X_{21} + X_{22})` と `(X_{11} + X_{21}) + (X_{12} + X_{22})` である。
  - 交換則: 零を単位元とする結合的で非可換な加法（文字列の連結、零は空の文字列）で `X_{11} = X_{22} = 0`、
    `X_{12} = a`、`X_{21} = b` とすると、両辺は `ab` と `ba` で一致しない。
  - 結合則: `{0, 1, 2}` に、`0` を単位元とし `1 + 1 = 2 + 2 = 0`、`1 + 2 = 2 + 1 = 1` で定まる可換で非結合的な加法を入れる
    （`(1 + 1) + 2 = 2`、`1 + (1 + 2) = 0`）。`X_{11} = X_{12} = 1`、`X_{21} = 2`、`X_{22} = 0` とすると、
    左辺は `(1 + 1) + (2 + 0) = 0 + 2 = 2`、右辺は `(1 + 2) + (1 + 0) = 1 + 1 = 0` で一致しない。
-/
import Ising2D.NecSuf.FiniteDoubleSumInterchange
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

/-- **必要十分版の `finite_double_sum_of_matrices_interchange`**: `Σ_a Σ_b X_{a,b} = Σ_b Σ_a X_{a,b}`。
具体版と同じ成分の鎖の 5 段と成分の一致。 -/
theorem finite_double_sum_of_matrices_interchange' {R : Type*} [AddCommMonoid R]
    {κ ι α β : Type*} [Fintype κ] [Fintype ι] (X : κ → ι → Matrix α β R) :
    ∑ a, ∑ b, X a b = ∑ b, ∑ a, X a b :=
  Matrix.ext fun i k =>
    calc (∑ a, ∑ b, X a b) i k
        = ∑ a, (∑ b, X a b) i k := Matrix.sum_apply i k Finset.univ _                 -- 行列の和は成分ごと
      _ = ∑ a, ∑ b, X a b i k :=
          Finset.sum_congr rfl fun a _ => Matrix.sum_apply i k Finset.univ (X a)       -- 同じことを各 `a` へ
      _ = ∑ b, ∑ a, X a b i k := finite_double_sum_interchange' _                      -- 成分の加法の結合則・交換則による順序交換
      _ = ∑ b, (∑ a, X a b) i k :=
          Finset.sum_congr rfl fun b _ =>
            (Matrix.sum_apply i k Finset.univ (fun a => X a b)).symm                   -- 行列の和は成分ごと（右辺から左辺へ、各 `b` へ）
      _ = (∑ b, ∑ a, X a b) i k := (Matrix.sum_apply i k Finset.univ _).symm         -- 行列の和は成分ごと（右辺から左辺へ）

end Ising2D.NecSuf
