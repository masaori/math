import Mathlib.Algebra.Field.Subfield.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 二係数表示の平方根と二の可逆性だけを使う平方完成。 -/
private theorem imaginaryUnitExtension_monicQuadraticRoot
    {K : Type*} [Field K] (F : Subfield K)
    (htwo : (2 : K) ≠ 0)
    (omega : K)
    (hsqrt : ∀ A B : K, A ∈ F → B ∈ F →
      ∃ u v : K, u ∈ F ∧ v ∈ F ∧
        (u + v * omega) * (u + v * omega) = A + B * omega)
    (p q : K) (homega : omega * omega = -1)
    (hp : ∃ a b : K, a ∈ F ∧ b ∈ F ∧ p = a + b * omega)
    (hq : ∃ c d : K, c ∈ F ∧ d ∈ F ∧ q = c + d * omega) :
    ∃ r x y : K, x ∈ F ∧ y ∈ F ∧ r = x + y * omega ∧
      r * r + p * r + q = 0 := by
  obtain ⟨a, b, ha, hb, hp⟩ := hp
  obtain ⟨c, d, hc, hd, hq⟩ := hq
  have htwoF : (2 : K) ∈ F := by
    convert F.add_mem F.one_mem F.one_mem using 1 <;> ring
  have hfourF : (4 : K) ∈ F := by
    convert F.mul_mem htwoF htwoF using 1 <;> ring
  let A : K := a * a - b * b - 4 * c
  let B : K := 2 * a * b - 4 * d
  have hA : A ∈ F := by
    dsimp [A]
    exact F.sub_mem (F.sub_mem (F.mul_mem ha ha) (F.mul_mem hb hb))
      (F.mul_mem hfourF hc)
  have hB : B ∈ F := by
    dsimp [B]
    exact F.sub_mem (F.mul_mem (F.mul_mem htwoF ha) hb)
      (F.mul_mem hfourF hd)
  have hdisc : p * p - 4 * q = A + B * omega := by
    dsimp [A, B]
    rw [hp, hq]
    linear_combination (b * b) * homega
  obtain ⟨u, v, hu, hv, hs⟩ := hsqrt A B hA hB
  let s : K := u + v * omega
  have hs' : s * s = p * p - 4 * q := by
    dsimp [s]
    rw [hs, ← hdisc]
  let x : K := (-a + u) / 2
  let y : K := (-b + v) / 2
  have hx : x ∈ F := by
    dsimp [x]
    exact F.div_mem (F.add_mem (F.neg_mem ha) hu) htwoF
  have hy : y ∈ F := by
    dsimp [y]
    exact F.div_mem (F.add_mem (F.neg_mem hb) hv) htwoF
  let r : K := (-p + s) / 2
  have hr : r = x + y * omega := by
    dsimp [r, x, y, s]
    rw [hp]
    field_simp
    ring
  have hroot : r * r + p * r + q = 0 := by
    dsimp [r]
    field_simp [htwo]
    linear_combination hs'
  exact ⟨r, x, y, hx, hy, hr, hroot⟩

/-- 係数が二係数表示を持つ部分体で割り、同じ平方完成を用いる。 -/
theorem imaginaryUnitExtension_quadraticRoot
    {K : Type*} [Field K] (F L : Subfield K)
    (htwo : (2 : K) ≠ 0)
    (omega : K)
    (hsqrt : ∀ A B : K, A ∈ F → B ∈ F →
      ∃ u v : K, u ∈ F ∧ v ∈ F ∧
        (u + v * omega) * (u + v * omega) = A + B * omega)
    (e p q : K) (homega : omega * omega = -1)
    (he0 : e ≠ 0) (he : e ∈ L) (hp : p ∈ L) (hq : q ∈ L)
    (hrep : ∀ z : K, z ∈ L →
      ∃ a b : K, a ∈ F ∧ b ∈ F ∧ z = a + b * omega) :
    ∃ r x y : K, x ∈ F ∧ y ∈ F ∧ r = x + y * omega ∧
      e * (r * r) + p * r + q = 0 := by
  obtain ⟨a, b, ha, hb, hP⟩ := hrep (p / e) (L.div_mem hp he)
  obtain ⟨c, d, hc, hd, hQ⟩ := hrep (q / e) (L.div_mem hq he)
  obtain ⟨r, x, y, hx, hy, hr, hroot⟩ :=
    imaginaryUnitExtension_monicQuadraticRoot F htwo omega hsqrt
      (p / e) (q / e) homega ⟨a, b, ha, hb, hP⟩ ⟨c, d, hc, hd, hQ⟩
  refine ⟨r, x, y, hx, hy, hr, ?_⟩
  calc
    e * (r * r) + p * r + q = e * (r * r + (p / e) * r + q / e) := by
      field_simp [he0]
    _ = 0 := by rw [hroot]; ring

end Ising2DLambda.NecSuf.FisherZero
