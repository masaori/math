/-
「接続階段とその周期並進は二つの持ち上げを単純閉路へ閉じる」の必要十分版。

閉包の終点を除く頂点を四部分の互いに素な和で添字づけると、本質は各部分の
単射性と、異なる二部分の像が交わらないことだけである。閉性と各辺が単位格子辺で
あることは、四部分の境界値と各部分の一歩から別々に渡す。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 四つの部分を、共有端点を片側だけに残した互いに素な添字集合から一つの列へ合成する。 -/
def fourSegmentVertex {I J K M X : Type*}
    (first : I → X) (second : J → X) (third : K → X) (fourth : M → X) :
    I ⊕ J ⊕ K ⊕ M → X
  | Sum.inl i => first i
  | Sum.inr (Sum.inl j) => second j
  | Sum.inr (Sum.inr (Sum.inl k)) => third k
  | Sum.inr (Sum.inr (Sum.inr m)) => fourth m

/-- 四部分がそれぞれ単射で、異なる部分の像が交わらなければ、合成列の頂点は相異なる。 -/
theorem four_segment_vertex_injective_necSuf
    {I J K M X : Type*}
    (first : I → X) (second : J → X) (third : K → X) (fourth : M → X)
    (hfirst : Function.Injective first)
    (hsecond : Function.Injective second)
    (hthird : Function.Injective third)
    (hfourth : Function.Injective fourth)
    (h12 : ∀ i j, first i ≠ second j)
    (h13 : ∀ i k, first i ≠ third k)
    (h14 : ∀ i m, first i ≠ fourth m)
    (h23 : ∀ j k, second j ≠ third k)
    (h24 : ∀ j m, second j ≠ fourth m)
    (h34 : ∀ k m, third k ≠ fourth m) :
    Function.Injective (fourSegmentVertex first second third fourth) := by
  intro x y hxy
  rcases x with i | j | k | m <;> rcases y with i' | j' | k' | m'
  · cases hfirst (by simpa [fourSegmentVertex] using hxy)
    rfl
  · exact False.elim (h12 i j' (by simpa [fourSegmentVertex] using hxy))
  · exact False.elim (h13 i k' (by simpa [fourSegmentVertex] using hxy))
  · exact False.elim (h14 i m' (by simpa [fourSegmentVertex] using hxy))
  · exact False.elim (h12 i' j (by simpa [fourSegmentVertex] using hxy.symm))
  · cases hsecond (by simpa [fourSegmentVertex] using hxy)
    rfl
  · exact False.elim (h23 j k' (by simpa [fourSegmentVertex] using hxy))
  · exact False.elim (h24 j m' (by simpa [fourSegmentVertex] using hxy))
  · exact False.elim (h13 i' k (by simpa [fourSegmentVertex] using hxy.symm))
  · exact False.elim (h23 j' k (by simpa [fourSegmentVertex] using hxy.symm))
  · cases hthird (by simpa [fourSegmentVertex] using hxy)
    rfl
  · exact False.elim (h34 k m' (by simpa [fourSegmentVertex] using hxy))
  · exact False.elim (h14 i' m (by simpa [fourSegmentVertex] using hxy.symm))
  · exact False.elim (h24 j' m (by simpa [fourSegmentVertex] using hxy.symm))
  · exact False.elim (h34 k' m (by simpa [fourSegmentVertex] using hxy.symm))
  · cases hfourth (by simpa [fourSegmentVertex] using hxy)
    rfl

/-- 四部分の相異なり、境界の閉性、各連続差の許容性を合成した単純閉路の核。 -/
theorem four_segments_form_simple_closed_walk_necSuf
    {I J K M X T : Type*}
    (first : I → X) (second : J → X) (third : K → X) (fourth : M → X)
    (hfirst : Function.Injective first)
    (hsecond : Function.Injective second)
    (hthird : Function.Injective third)
    (hfourth : Function.Injective fourth)
    (h12 : ∀ i j, first i ≠ second j)
    (h13 : ∀ i k, first i ≠ third k)
    (h14 : ∀ i m, first i ≠ fourth m)
    (h23 : ∀ j k, second j ≠ third k)
    (h24 : ∀ j m, second j ≠ fourth m)
    (h34 : ∀ k m, third k ≠ fourth m)
    (start finish : X) (hclosed : finish = start)
    (AllowedStep : X → X → Prop) (edgeStart edgeFinish : T → X)
    (hsteps : ∀ t, AllowedStep (edgeStart t) (edgeFinish t)) :
    Function.Injective (fourSegmentVertex first second third fourth) ∧
      finish = start ∧ ∀ t, AllowedStep (edgeStart t) (edgeFinish t) := by
  constructor
  · exact four_segment_vertex_injective_necSuf first second third fourth
      hfirst hsecond hthird hfourth h12 h13 h14 h23 h24 h34
  constructor
  · exact hclosed
  · exact hsteps

end Ising2DLambda.NecSuf.KacWard
