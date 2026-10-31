/-
必要十分版: 軌道ごとの成分積を定数埋め込みの外へ出し、既知の位相・ねじれ値を代入する。

人手証明が使うのは、有限積、単位元と積を保つ写像、各軌道の成分積の値だけである。
置換、向き付き辺、代数的数、多項式、切断線偶奇、回転数は現れない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 単位元と積を保つ写像は有限積を保つ。 -/
private theorem map_finset_prod {A B E : Type*} [CommMonoid A] [CommMonoid B]
    (embed : A → B) (hone : embed 1 = 1) (hmul : ∀ x y, embed (x * y) = embed x * embed y)
    (u : E → A) (t : Finset E) :
    embed (∏ e ∈ t, u e) = ∏ e ∈ t, embed (u e) := by
  classical
  induction t using Finset.induction_on with
  | empty => simp [hone]
  | @insert e t he ih =>
      rw [prod_insert he, hmul, prod_insert he, ih]

/-- 軌道表示へ定数埋め込みの乗法性を適用し、各軌道の既知の値を代入する。 -/
theorem termOrbitPhaseTwist_necSuf {A B I E : Type*} [CommMonoid A] [CommMonoid B]
    (orbits : Finset I) (support : I → Finset E) (entry : I → E → A)
    (phaseTwist : I → A) (coefficient : I → B) (embed : A → B) (term : B)
    (hone : embed 1 = 1) (hmul : ∀ x y, embed (x * y) = embed x * embed y)
    (hterm : term = ∏ i ∈ orbits, coefficient i * ∏ e ∈ support i, embed (entry i e))
    (hphase : ∀ i ∈ orbits, ∏ e ∈ support i, entry i e = phaseTwist i) :
    term = ∏ i ∈ orbits, coefficient i * embed (phaseTwist i) := by
  rw [hterm]
  refine Finset.prod_congr rfl ?_
  intro i hi
  rw [← map_finset_prod embed hone hmul (entry i) (support i), hphase i hi]

end Ising2DLambda.NecSuf.KacWard
