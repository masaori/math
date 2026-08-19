/-
「ずらした自由族は零点の集合が極限量を決めないことの反例である」の
Lean 必要十分版からの導出。

既約分解型の必要十分版 `value_invariant_does_not_determine_limit_quantity` は、
不変量の二つの値の不一致・フィルタを保つ添字写像・二列の項別一致・Hausdorff 空間での
極限一意性だけを仮定し、値の型は任意である。本主張の抽象形はこれがそのまま担う：
値の型を `Finset ℕ`（零点のモニック最小多項式次数の有限集合）、二つの値を
`freeBoxTwoRootMinimalDegrees` と `shiftedFreeBoxTwoRootMinimalDegrees`、不一致を
`rootMinimalDegreeSets_differ_at_two`、添字写像を末尾ずらしに取ればよい。
結論の項別一致の連言肢は仮定に使った既存補題
`shiftedFreeFiniteBoxQuantitySeq_eq_tail` を添えるだけである。非可算への脱出は、二つの有限箱量列が
それぞれ実数へ収束するという仮定 `h` と `h'` に現れる箱の大きさの極限だけである。
-/
import Ising3DCut.LimitQuantity.RootSetDoesNotDetermineLimitQuantity
import Ising3DCut.LimitQuantity.FactorizationTypeDoesNotDetermineLimitQuantityAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版 `root_set_does_not_determine_limit_quantity` は必要十分版
`value_invariant_does_not_determine_limit_quantity` の特殊化として導出できる。 -/
theorem root_set_does_not_determine_limit_quantity_fromNecSuf
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    freeBoxTwoRootMinimalDegrees ≠ shiftedFreeBoxTwoRootMinimalDegrees ∧
      (∀ n, shiftedFreeFiniteBoxQuantitySeq q N n =
        rootSeq (finiteBoxValueSeq q) N (n + 1)) ∧
      α' = α := by
  obtain ⟨hne, heq⟩ := value_invariant_does_not_determine_limit_quantity
    freeBoxTwoRootMinimalDegrees
    shiftedFreeBoxTwoRootMinimalDegrees
    rootMinimalDegreeSets_differ_at_two
    atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq q) N) (shiftedFreeFiniteBoxQuantitySeq q N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail q N) α α' h h'
  exact ⟨hne, shiftedFreeFiniteBoxQuantitySeq_eq_tail q N, heq⟩

end Ising3DCut.LimitQuantity
