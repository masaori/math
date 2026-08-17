/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版は新設しない。「三分法（比較可能性）と推移律から最小元の存在、非対称性から一意性」
という議論は `NecSuf.AlgebraicEigenvalue.existsUnique_min`（行配位の最小元のために書いたもの）が
既にその必要十分な形で持っており、同じ議論を二箇所に置かない。
具体側の仕事は ι := R の元、lt := `realAlgebraicLt` を代入し、次の 3 つを供給することだけである。

1. `hcompare`: 相異なる 2 元は `<_R` で比較できる（三分法の網羅性の一部）。
2. `htrans`: 推移律（`realAlgebraicLt_trans`）。
3. `hasymm`: 非対称性（三分法の「ちょうど 1 つ」の一部）。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicMinUnique
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowConfigMin

namespace Ising2DLambda.FisherZero

/-- 相異なる 2 元は `<_R` で比較できる（三分法の網羅性から）。 -/
theorem realAlgebraicLt_compare (data : RealClosedSubfieldData) (a b : data.carrier)
    (h : a ≠ b) : realAlgebraicLt data a b ∨ realAlgebraicLt data b a := by
  rcases (realAlgebraicLt_trichotomy data a b).1 with hc | hc | hc
  · exact Or.inl hc
  · exact absurd hc h
  · exact Or.inr hc

/-- `<_R` は非対称である（三分法の「ちょうど 1 つ」から）。 -/
theorem realAlgebraicLt_asymm (data : RealClosedSubfieldData) {a b : data.carrier}
    (h : realAlgebraicLt data a b) : ¬ realAlgebraicLt data b a := fun h' =>
  (realAlgebraicLt_trichotomy data a b).2.2.1 ⟨h, h'⟩

/-- 具体版の最小元の条件が、必要十分版の `IsMin` と同じ述語であること。 -/
theorem isRealAlgebraicMin_eq_necSuf (data : RealClosedSubfieldData)
    (X : Finset data.carrier) (m : data.carrier) :
    IsRealAlgebraicMin data X m =
      NecSuf.AlgebraicEigenvalue.IsMin (realAlgebraicLt data) X m := rfl

/-- 主張「実閉部分体の空でない有限集合は最小元をちょうど 1 つ持つ」を、
必要十分版から導いたもの。 -/
theorem existsUnique_realAlgebraicMin_from_necSuf (data : RealClosedSubfieldData)
    {X : Finset data.carrier} (hX : X.Nonempty) :
    ∃! m : data.carrier, IsRealAlgebraicMin data X m := by
  classical
  exact NecSuf.AlgebraicEigenvalue.existsUnique_min (lt := realAlgebraicLt data)
    (realAlgebraicLt_compare data)
    (fun hab hbc => realAlgebraicLt_trans data _ _ _ hab hbc)
    (fun h => realAlgebraicLt_asymm data h) hX

end Ising2DLambda.FisherZero
