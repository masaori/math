/-
# 各射影の上で符号の積として働けば、全体がパリティの定数倍になる（**必要十分版**）

対応する人手証明: `epsilon_eigenvalue_on_check_Q` (4) の後半（正本は
`structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean` の
`CheckFermi.epsilon_mul_Qproj_eq_smul_parityProd_mul`（7 行の鎖）・`CheckFermi.epsilon_eq_parityProd_succ`（9 行の鎖）で、
その特殊化 `*_of_necSuf` を同じファイルに置く。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `εQ̌_ε = c(PQ̌_ε)` の 7 行（`c := η_{(1,…,1)}(−1)^{M_col}`） | `mul_eq_smul_mul_of_sign_pow'` の 7 行（同じ並び） |
| 7 行の 3 行目の根拠 `(−1)^{\|ε\|}(−1)^{\|ε\|} = ((−1)(−1))^{\|ε\|} = 1^{\|ε\|} = 1` | `neg_one_pow_mul_self'` の 3 行（同じ並び） |
| `ε = εI = … = cP` の 9 行 | `eq_smul_of_mul_eq_smul_mul'` の 8 行（最後の「`c`, `P` の置き方」の行は具体版だけにある） |

## 何が効いているか / 効いていないか

- 7 行の鎖に効くのは、係数の集合 `𝕜` の積の結合則と単位元（`Monoid 𝕜`）、`(−1)(−1) = 1`（`HasDistribNeg 𝕜`。`−1` が `−1` と
  可換であることも `Commute.refl` で、積の可換則は使わない）、指数法則 `z^a z^b = z^{a+b}` と `z^a w^a = (zw)^a`
  （`z, w` が可換なとき。ここでは `z = w = −1`）、`a(bx) = (ab)x`（`SemigroupAction 𝕜 R`。`1x = x` は効かない）だけである。
  `R` は積の記号 `Mul R` を持つだけで、`R` の結合則・分配則・単位元は効かない。`η_ε ∈ {±1}`、`𝕜` の加法は効かない。
  指数の `M − |ε|` は自然数の差で、`|ε| ≤ M` の仮定 `hk` は `(M − |ε|) + |ε| = M` にだけ効く。
- 9 行の鎖に効くのは、`1` が積の右単位元であること（`MulOneClass R`）、`{0,1}^{r+1}` の上の和が右因子の和に分配すること
  （`binWordSum_map`。加法は `Add R` だけで、効くのは左分配則 `LeftDistribClass R`）、スカラー倍が左因子から外へ出ること
  （`IsScalarTower 𝕜 R R`）だけである。`R` の積の結合則、加法の結合則・可換則・零元、`Q̌_ε` の冪等性・直交性、
  `c ∈ {±1}`、`𝕜` の積の構造は効かない。
  `R` の左単位元（`1 * x = x`）も効かないが、mathlib に右単位元だけを表すクラスが無いので `MulOneClass R` で受ける。人手の (2) の `Σ_εQ̌_ε = I` は仮定 `hsum` として受ける。
-/
import Ising2D.NecSuf.BinaryWordSum
import Mathlib.Algebra.Group.Commute.Basic
import Mathlib.Algebra.GroupWithZero.Action.Defs

namespace Ising2D.NecSuf

/-- **7 行の鎖の 3 行目の根拠の必要十分版**: `(−1)^k(−1)^k = ((−1)(−1))^k = 1^k = 1`（`Monoid 𝕜` と `HasDistribNeg 𝕜`）。 -/
theorem neg_one_pow_mul_self' {𝕜 : Type*} [Monoid 𝕜] [HasDistribNeg 𝕜] (k : ℕ) :
    (-1 : 𝕜) ^ k * (-1 : 𝕜) ^ k = 1 :=
  calc (-1 : 𝕜) ^ k * (-1 : 𝕜) ^ k
      = ((-1 : 𝕜) * (-1 : 𝕜)) ^ k := ((Commute.refl (-1 : 𝕜)).mul_pow k).symm
                                                               -- `z^a w^a = (zw)^a`（`zw = wz` のとき）
    _ = (1 : 𝕜) ^ k := by rw [neg_one_mul, neg_neg]            -- `(−1)(−1) = 1`
    _ = 1 := one_pow k                                         -- `1^a = 1`

/-- **`εQ̌_ε = c(PQ̌_ε)` の 7 行の鎖の必要十分版**: `eQ = η_εQ`、`η_ε = η(−1)^{m−k}`、`PQ = (−1)^kQ`、`k ≤ m` なら
`eQ = (η(−1)^m)(PQ)`。具体版の `ε` が `e`、`η_{(1,…,1)}` が `η`、`M_col` が `m`、`|ε|` が `k` である。 -/
theorem mul_eq_smul_mul_of_sign_pow' {𝕜 R : Type*} [Monoid 𝕜] [HasDistribNeg 𝕜] [Mul R] [SemigroupAction 𝕜 R]
    (e P Q : R) (η ηε : 𝕜) (m k : ℕ) (hk : k ≤ m)
    (h1 : e * Q = ηε • Q) (h3 : ηε = η * (-1 : 𝕜) ^ (m - k)) (hP : P * Q = (-1 : 𝕜) ^ k • Q) :
    e * Q = (η * (-1 : 𝕜) ^ m) • (P * Q) :=
  calc e * Q
      = ηε • Q := h1                                           -- 仮定（具体版の (1)）
    _ = (η * (-1 : 𝕜) ^ (m - k)) • Q := by rw [h3]             -- 仮定（具体版の (3)）
    _ = (η * (-1 : 𝕜) ^ (m - k) * ((-1 : 𝕜) ^ k * (-1 : 𝕜) ^ k)) • Q := by
        rw [neg_one_pow_mul_self', mul_one]                    -- `(−1)^k(−1)^k = 1`
    _ = (η * ((-1 : 𝕜) ^ (m - k) * (-1 : 𝕜) ^ k) * (-1 : 𝕜) ^ k) • Q := by
        rw [← mul_assoc (η * (-1 : 𝕜) ^ (m - k)), mul_assoc η]  -- `𝕜` の積の結合則
    _ = (η * (-1 : 𝕜) ^ m * (-1 : 𝕜) ^ k) • Q := by
        rw [← pow_add, Nat.sub_add_cancel hk]                  -- `z^a z^b = z^{a+b}`（`(m − k) + k = m`）
    _ = (η * (-1 : 𝕜) ^ m) • ((-1 : 𝕜) ^ k • Q) := mul_smul _ _ _
                                                               -- `(ab)x = a(bx)`
    _ = (η * (-1 : 𝕜) ^ m) • (P * Q) := by rw [hP]             -- 仮定（`PQ = (−1)^kQ`）

/-- **`ε = εI = … = cP` の 9 行の鎖の必要十分版**: `Σ_εQ_ε = 1`（`{0,1}^{r+1}` の上の和 `binWordSum`）で、
すべての `ε` で `eQ_ε = c(PQ_ε)` なら `e = cP`。 -/
theorem eq_smul_of_mul_eq_smul_mul' {𝕜 R : Type*} [MulOneClass R] [Add R] [LeftDistribClass R] [SMul 𝕜 R]
    [IsScalarTower 𝕜 R R] (r : ℕ) (e P : R) (c : 𝕜) (Q : (Fin (r + 1) → Fin 2) → R)
    (hsum : binWordSum r Q = 1) (h : ∀ ε, e * Q ε = c • (P * Q ε)) :
    e = c • P :=
  calc e
      = e * 1 := (mul_one e).symm                              -- `1` は右単位元
    _ = e * binWordSum r Q := by rw [hsum]                     -- 仮定 `Σ_εQ_ε = 1`
    _ = binWordSum r (fun ε => e * Q ε) := binWordSum_map (e * ·) (fun a b => mul_add e a b) r Q
                                                               -- 和は右因子の和に分配する
    _ = binWordSum r (fun ε => c • (P * Q ε)) := by
        congr 1; funext ε; exact h ε                           -- 仮定を全ての `ε` へ同時に適用
    _ = binWordSum r (fun ε => (c • P) * Q ε) := by
        congr 1; funext ε; exact (smul_mul_assoc c P (Q ε)).symm
                                                               -- スカラー倍は左因子から外へ出る（右辺から左辺へ）
    _ = (c • P) * binWordSum r Q :=
        (binWordSum_map ((c • P) * ·) (fun a b => mul_add (c • P) a b) r Q).symm
                                                               -- 和は右因子の和に分配する（右辺から左辺へ）
    _ = (c • P) * 1 := by rw [hsum]                            -- 仮定 `Σ_εQ_ε = 1`
    _ = c • P := mul_one _                                     -- `1` は右単位元

end Ising2D.NecSuf
