/-
「全スピン反転は各辺の破れを保つ」の必要十分版。
必要なのは、両端の値へ同じ単射を施すことだけである。
-/
namespace Ising2DLambda.NecSuf.FisherZero

theorem injective_map_ne_iff {A B : Type} (f : A → B) (hf : Function.Injective f) (a b : A) :
    f a ≠ f b ↔ a ≠ b := by
  constructor
  · intro hfab hab
    exact hfab (congrArg f hab)
  · intro hab hfab
    exact hab (hf hfab)

end Ising2DLambda.NecSuf.FisherZero
