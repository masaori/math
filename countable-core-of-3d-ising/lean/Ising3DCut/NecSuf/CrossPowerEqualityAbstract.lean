/-
「交差べき等式は乗根の一致を決める」の Lean 必要十分版（抽象版）。

具体版 `cross_power_equality_implies_posRoot_equality` は正の実数と `posRoot` を
使うが、証明の本体はべき乗の指数法則（モノイド）と、`N * M` 乗写像が二つの元を
区別しないなら元が等しいという単射性の仮定だけで動く。順序・正値性・実数は
単射性を供給するための具体構造にすぎないので、ここではモノイド `G` の元
`x`, `y`（乗根にあたる）と `A`, `B`（箱値にあたる）について、
`x ^ N = A`, `y ^ M = B`, 交差べき等式 `A ^ M = B ^ N`、および
`N * M` 乗写像の単射性から `x = y` を導く。可換性も使わない。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising3DCut.NecSuf

/-- 交差べき等式は乗根の一致を決める（抽象版）。
モノイドのべき乗則と `N * M` 乗写像の単射性だけを仮定する。 -/
theorem cross_power_equality_implies_root_equality_abstract
    {G : Type*} [Monoid G] (x y A B : G) (N M : ℕ)
    (hxN : x ^ N = A) (hyM : y ^ M = B)
    (hcross : A ^ M = B ^ N)
    (hinj : Function.Injective fun g : G => g ^ (N * M)) :
    x = y := by
  apply hinj
  show x ^ (N * M) = y ^ (N * M)
  calc
    x ^ (N * M) = (x ^ N) ^ M := by rw [pow_mul]
    _ = A ^ M := by rw [hxN]
    _ = B ^ N := hcross
    _ = (y ^ M) ^ N := by rw [hyM]
    _ = y ^ (M * N) := by rw [pow_mul]
    _ = y ^ (N * M) := by rw [Nat.mul_comm]

end Ising3DCut.NecSuf
