/-
# `𝓕^{(+)}` の上で `W` と `V^{(+)}` が一致すること（必要十分版）

具体版: `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimWEqVPlusOnEvenSector.lean`
（人手 `c_plus_equals_Lambda_half_integer` の Step 0）。

## 具体版との手順の対応

| 具体版（人手 Step 0 の行） | 必要十分版 |
| --- | --- |
| `epsProjPlus_mulVec_of_even` 1 行目 `P^{(+)}x = ½(x + εx)` | `invProj_smul_of_fixed` 1 行目 |
| 同 2 行目 `= ½(x + x)` | 同 2 行目 |
| 同 3 行目 `= x` | 同 3 行目 |
| `W_mulVec_eq_VPlus_mulVec_of_even` 1 行目 `Wx = WP^{(+)}x` | `smul_eq_of_mul_proj_eq` 1 行目 |
| 同 2 行目 `= V^{(+)}P^{(+)}x` | 同 2 行目 |
| 同 3 行目 `= V^{(+)}x` | 同 3 行目 |

## 何が効いているか / 効いていないか

- 前半（`P^{(+)}x = x`）に効いているのは、作用が加法と両立すること（環 `R` 上の加群）、`1` が恒等的に作用すること、
  `2` が `R` で可逆であることだけである。`2` の可逆性は `P^{(+)} = ⅟2 (1 + ε)` を書くために要り、
  削ると `P^{(+)}` 自体が定義できない。加法の逆元は使わないが、`R` を環とするのは `invProj` の定義
  （`NecSuf/Projector.lean`）が環を要求するためである。`ε² = 1` も `ε` が行列であることも、係数が `ℂ` であることも効いていない。
- 後半（`Wx = V^{(+)}x`）に効いているのは、作用が積と両立すること（`(AB)x = A(Bx)`）だけである。
  加法も単位元も `2` の可逆性も使わないので、半群の作用で述べる。`W`・`V^{(+)}` の具体形、
  `W P^{(+)} = V^{(+)} P^{(+)}` がどう得られたか（章 011 の `sandwich_mul_proj_eq`）は効いていない。
-/
import Ising2D.NecSuf.Projector
import Mathlib.Algebra.Module.Defs

namespace Ising2D.NecSuf

/-- **人手 Step 0 の前半の必要十分版**: `e f = f` なら `P f = f`（`P = ⅟2 (1 + e)`）。 -/
theorem invProj_smul_of_fixed {R V : Type*} [Ring R] [Invertible (2 : R)] [AddCommGroup V]
    [Module R V] {e : R} {f : V} (hf : e • f = f) : invProj e • f = f :=
  calc invProj e • f
      = ⅟(2 : R) • (f + e • f) := by
        -- `P` の定義
        rw [invProj, mul_smul, add_smul, one_smul]
    _ = ⅟(2 : R) • (f + f) := by
        -- `e f = f`
        rw [hf]
    _ = f := by
        -- スカラー倍を整理する（`⅟2 · 2 = 1`）
        rw [← two_smul R f, ← mul_smul, invOf_mul_self, one_smul]

/-- **人手 Step 0 の後半の必要十分版**: `B P = C P` かつ `P f = f` なら `B f = C f`。 -/
theorem smul_eq_of_mul_proj_eq {R V : Type*} [Semigroup R] [SemigroupAction R V] {B C P : R} {f : V}
    (hBP : B * P = C * P) (hP : P • f = f) : B • f = C • f :=
  calc B • f
      = B • (P • f) := by
        -- `P f = f`
        rw [hP]
    _ = C • (P • f) := by
        -- `B P = C P`
        rw [← mul_smul, hBP, mul_smul]
    _ = C • f := by
        -- `P f = f`
        rw [hP]

end Ising2D.NecSuf
