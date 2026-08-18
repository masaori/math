/-
「ずらした自由族は既約分解の型が極限量を決めないことの反例である」の
Lean 必要十分版。

既約因子のリスト・具体的な次数と重複度・実数列は本質ではない。証明が使うのは、
不変量の二つの値が異なること、添字写像がフィルタを保つこと、二つの列が項ごとに
末尾ずらしで一致すること、Hausdorff 空間での極限の一意性だけである。
Galois 群の必要十分版が位数の可除性を残したのに対し、こちらは不一致そのものを
仮定に置くので、値の型は任意でよい。
-/
import Ising3DCut.LimitQuantity.FactorizationTypeDoesNotDetermineLimitQuantity
import Ising3DCut.LimitQuantity.TailShiftLimitAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 必要十分版：不変量の二つの値が異なる二対象の列が同じ極限を持つなら、
その不変量は極限量を決めない。 -/
theorem value_invariant_does_not_determine_limit_quantity
    {V ι X : Type*} [TopologicalSpace X] [T2Space X]
    (v v' : V) (hne : v ≠ v')
    (F : Filter ι) [F.NeBot] (shift : ι → ι) (hshift : Tendsto shift F F)
    (a a' : ι → X) (hpoint : ∀ i, a' i = a (shift i))
    (x x' : X) (ha : Tendsto a F (𝓝 x)) (ha' : Tendsto a' F (𝓝 x')) :
    v ≠ v' ∧ x' = x :=
  ⟨hne, shiftedSequence_limit_eq F shift hshift a a' hpoint x x' ha ha'⟩

/-- 具体版は必要十分版の特殊化として導出できる。値の型を (次数, 重複度) の
リストに、不一致を決定計算に、添字写像を末尾ずらしに取る。 -/
theorem factorization_type_does_not_determine_limit_quantity_fromNecSuf
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    freeBoxTwoFactorizationType ≠ shiftedFreeBoxTwoFactorizationType ∧ α' = α :=
  value_invariant_does_not_determine_limit_quantity
    freeBoxTwoFactorizationType shiftedFreeBoxTwoFactorizationType (by decide)
    atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq q) N) (shiftedFreeFiniteBoxQuantitySeq q N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail q N) α α' h h'

end Ising3DCut.LimitQuantity
