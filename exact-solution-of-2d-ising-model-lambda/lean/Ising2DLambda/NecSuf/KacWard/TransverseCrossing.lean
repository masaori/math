/-
「二つの通過の横断関係は順序に依らない」（`claim_transverse_crossing_symmetric`）の必要十分版。

人手証明が使うのは、二つの通過がともに直進であるという二条件の交換と、
二つの軸が異なるという関係の対称性だけである。辺・格子・方向番号・有限性は使わない。
-/
namespace Ising2DLambda.NecSuf.KacWard

/-- 二つの局所データがともに条件 `straight` を満たし、軸が `different` の関係にあることは、
`different` が対称ならば二つの局所データの順序に依らない。 -/
theorem transverse_crossing_symmetric_necSuf {V : Type} {A : Type}
    (straight : V → Prop) (axis : V → A) (different : A → A → Prop)
    (different_symm : ∀ a b, different a b → different b a) (u v : V) :
    (straight u ∧ straight v ∧ different (axis u) (axis v)) ↔
      (straight v ∧ straight u ∧ different (axis v) (axis u)) := by
  constructor
  · rintro ⟨hu, hv, hdiff⟩
    exact ⟨hv, hu, different_symm _ _ hdiff⟩
  · rintro ⟨hv, hu, hdiff⟩
    exact ⟨hu, hv, different_symm _ _ hdiff⟩

end Ising2DLambda.NecSuf.KacWard
