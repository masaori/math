/-
「ずらした自由族は有限箱の分配多項式値が極限量に必要でないことの反例である」の
Lean 必要十分版からの導出。

既約分解型の必要十分版 `value_invariant_does_not_determine_limit_quantity` は、
不変量の二つの値の不一致・フィルタを保つ添字写像・二列の項別一致・Hausdorff 空間での
極限一意性だけを仮定し、値の型は任意である。本主張の抽象形はこれがそのまま担う：
値の型を ℤ、二つの値を $Z_2(1)$ と $Z_3(1)$、不一致を
`partitionValue_invariant_differs_at_two`、添字写像を末尾ずらしに取ればよい。
結論の項別一致の連言肢は仮定に使った既存補題
`shiftedFreeFiniteBoxQuantitySeq_eq_tail` を添えるだけである。ℝ への脱出は無い。
-/
import Ising3DCut.LimitQuantity.PartitionValueInvariantDiffersAtTwo
import Ising3DCut.LimitQuantity.FactorizationTypeDoesNotDetermineLimitQuantityAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版 `partition_value_does_not_determine_limit_quantity` は必要十分版
`value_invariant_does_not_determine_limit_quantity` の特殊化として導出できる。 -/
theorem partition_value_does_not_determine_limit_quantity_fromNecSuf
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    (NullModel.partitionPolynomial 2).eval 1 ≠
        (NullModel.partitionPolynomial 3).eval 1 ∧
      (∀ n, shiftedFreeFiniteBoxQuantitySeq q N n =
        rootSeq (finiteBoxValueSeq q) N (n + 1)) ∧
      α' = α := by
  obtain ⟨hne, heq⟩ := value_invariant_does_not_determine_limit_quantity
    ((NullModel.partitionPolynomial 2).eval 1)
    ((NullModel.partitionPolynomial 3).eval 1)
    partitionValue_invariant_differs_at_two
    atTop (fun n => n + 1) (tendsto_add_atTop_nat 1)
    (rootSeq (finiteBoxValueSeq q) N) (shiftedFreeFiniteBoxQuantitySeq q N)
    (shiftedFreeFiniteBoxQuantitySeq_eq_tail q N) α α' h h'
  exact ⟨hne, shiftedFreeFiniteBoxQuantitySeq_eq_tail q N, heq⟩

end Ising3DCut.LimitQuantity
