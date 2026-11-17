/-
「部分体の正錐に従う前錐」と、前錐に一つの元を付け足す二つの主張の必要十分版。

定義が実際に使うのは、加法・乗法と部分集合への所属だけである。`F ⊆ E` と `CF` が `F` の正錐であることは、
二つの主張の証明が一度も使わないので、必要十分版の定義から外す（具体版との対応は導出版が述べる）。
台が体であること、`E` が逆元で閉じること、代数閉性、可算性は要らない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Data.Set.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ising2DLambda.NecSuf.FisherZero

/-- 加法・乗法を持つ型の部分集合 `E` の上で、`C` を含む前錐 `T`。 -/
structure IsPreconeOn {K : Type*} [Add K] [Mul K] (E C T : Set K) : Prop where
  subset : ∀ z : K, z ∈ T → z ∈ E
  add_mem : ∀ a b : K, a ∈ T → b ∈ T → a + b ∈ T
  mul_mem : ∀ a b : K, a ∈ T → b ∈ T → a * b ∈ T
  sq_mem : ∀ y : K, y ∈ E → y * y ∈ T
  cone_subset : ∀ c : K, c ∈ C → c ∈ T

/-- 集合 `{t + a·t' | t ∈ T, t' ∈ T}`。 -/
def adjoinSet {K : Type*} [Add K] [Mul K] (T : Set K) (a : K) : Set K :=
  {z | ∃ t : K, t ∈ T ∧ ∃ t' : K, t' ∈ T ∧ z = t + a * t'}

/-- 具体版と同じ段で示す。積の並べ替えに乗法の交換則を使うので可換半環が要る
（符号反転は使わない）。`E` が零元・単位元を含み和と積で閉じることは、
零元・単位元の所属と `T⟨a⟩ ⊆ E` に要る。 -/
theorem preconeAdjoin_isPreconeOn_necSuf {K : Type*} [CommSemiring K] (E C T : Set K)
    (hE0 : (0 : K) ∈ E) (hE1 : (1 : K) ∈ E)
    (hEadd : ∀ x y : K, x ∈ E → y ∈ E → x + y ∈ E)
    (hEmul : ∀ x y : K, x ∈ E → y ∈ E → x * y ∈ E)
    (hT : IsPreconeOn E C T) (a : K) (ha : a ∈ E) :
    IsPreconeOn E C (adjoinSet T a) ∧ (∀ t : K, t ∈ T → t ∈ adjoinSet T a) ∧
      a ∈ adjoinSet T a := by
  have h0 : (0 : K) ∈ T := by
    have h := hT.sq_mem 0 hE0
    rw [mul_zero] at h
    exact h
  have h1 : (1 : K) ∈ T := by
    have h := hT.sq_mem 1 hE1
    rw [mul_one] at h
    exact h
  have hincl : ∀ t : K, t ∈ T → t ∈ adjoinSet T a := by
    intro t ht
    refine ⟨t, ht, 0, h0, ?_⟩
    rw [mul_zero, add_zero]
  have hself : a ∈ adjoinSet T a := by
    refine ⟨0, h0, 1, h1, ?_⟩
    rw [mul_one, zero_add]
  refine ⟨⟨?_, ?_, ?_, ?_, ?_⟩, hincl, hself⟩
  · rintro z ⟨t, ht, t', ht', rfl⟩
    exact hEadd _ _ (hT.subset t ht) (hEmul _ _ ha (hT.subset t' ht'))
  · rintro z1 z2 ⟨t1, ht1, t2, ht2, rfl⟩ ⟨t3, ht3, t4, ht4, rfl⟩
    refine ⟨t1 + t3, hT.add_mem _ _ ht1 ht3, t2 + t4, hT.add_mem _ _ ht2 ht4, ?_⟩
    calc (t1 + a * t2) + (t3 + a * t4) = (t1 + t3) + (a * t2 + a * t4) := by ring
      _ = (t1 + t3) + a * (t2 + t4) := by rw [mul_add]
  · rintro z1 z2 ⟨t1, ht1, t2, ht2, rfl⟩ ⟨t3, ht3, t4, ht4, rfl⟩
    have hsq : a * a ∈ T := hT.sq_mem a ha
    have hA : t1 * t3 + (a * a) * (t2 * t4) ∈ T :=
      hT.add_mem _ _ (hT.mul_mem _ _ ht1 ht3) (hT.mul_mem _ _ hsq (hT.mul_mem _ _ ht2 ht4))
    have hB : t1 * t4 + t2 * t3 ∈ T :=
      hT.add_mem _ _ (hT.mul_mem _ _ ht1 ht4) (hT.mul_mem _ _ ht2 ht3)
    refine ⟨_, hA, _, hB, ?_⟩
    calc (t1 + a * t2) * (t3 + a * t4)
        = t1 * t3 + t1 * (a * t4) + (a * t2) * t3 + (a * t2) * (a * t4) := by ring
      _ = (t1 * t3 + (a * a) * (t2 * t4)) + a * (t1 * t4 + t2 * t3) := by ring
  · intro y hy
    exact hincl _ (hT.sq_mem y hy)
  · intro c hc
    exact hincl _ (hT.cone_subset c hc)

/-- 具体版と同じ背理法と四行。符号反転と `-1` を使うので可換環が要る。
前錐の条件のうち使うのは和・積と `a·a ∈ T` だけで、`T ⊆ E`・`C ⊆ T` は使わない。
`a·a ∈ T` は具体版では `a ∈ E` と平方の条件から出るので、その形の仮定に絞る。 -/
theorem neg_one_not_mem_adjoin_or_necSuf {K : Type*} [CommRing K] (T : Set K)
    (hadd : ∀ x y : K, x ∈ T → y ∈ T → x + y ∈ T)
    (hmul : ∀ x y : K, x ∈ T → y ∈ T → x * y ∈ T)
    (hneg : (-1 : K) ∉ T) (a : K) (hsq : a * a ∈ T) :
    (-1 : K) ∉ adjoinSet T a ∨ (-1 : K) ∉ adjoinSet T (-a) := by
  by_contra hcon
  rw [not_or, not_not, not_not] at hcon
  obtain ⟨⟨t1, ht1, t2, ht2, h1⟩, ⟨t3, ht3, t4, ht4, h3⟩⟩ := hcon
  have e1 : a * t2 = -1 - t1 := by linear_combination -h1
  have e3 : (-a) * t4 = -1 - t3 := by linear_combination -h3
  have key : (-1 : K) = (t1 + t3 + t1 * t3) + (a * a) * (t2 * t4) := by
    calc (-1 : K) = (t1 + t3 + t1 * t3) - (1 + t1 + t3 + t1 * t3) := by ring
      _ = (t1 + t3 + t1 * t3) - (-1 - t1) * (-1 - t3) := by ring
      _ = (t1 + t3 + t1 * t3) - (a * t2) * ((-a) * t4) := by rw [e1, e3]
      _ = (t1 + t3 + t1 * t3) + (a * a) * (t2 * t4) := by ring
  have hhead : t1 + t3 + t1 * t3 ∈ T := hadd _ _ (hadd _ _ ht1 ht3) (hmul _ _ ht1 ht3)
  have htail : (a * a) * (t2 * t4) ∈ T := hmul _ _ hsq (hmul _ _ ht2 ht4)
  have hmem : (-1 : K) ∈ T := by
    rw [key]
    exact hadd _ _ hhead htail
  exact hneg hmem

end Ising2DLambda.NecSuf.FisherZero
