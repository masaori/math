/-
必要十分版: 軌道列に沿う遷移成分積を、ねじれ符号の積と回転位相の積へ分ける。

人手証明が使うのは、各成分がねじれ因子と位相因子の積であること、軌道列を
置換で一つ進めても同じ有限集合を一度ずつ走ること、可換モノイドの有限積だけである。
トーラス、向き付き辺、代数的数、回転数は、二つの因子積の値を確定する具体側の
データなので、この積の分離そのものには現れない。
-/
import Mathlib.Algebra.BigOperators.Group.List.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 軌道上の成分積を、添字を付け替えた第一因子と第二因子の積へ分ける。 -/
theorem orbitEntryProduct_phase_twist_necSuf {E K : Type*} [CommMonoid K]
    (walk : List E) (f : E → E) (entry phase : E → E → K) (twist : E → K)
    (twistTotal phaseTotal : K)
    (hentry : ∀ e ∈ walk, entry e (f e) = twist (f e) * phase e (f e))
    (hperm : (walk.map f).Perm walk)
    (htwist : (walk.map twist).prod = twistTotal)
    (hphase : (walk.map fun e => phase e (f e)).prod = phaseTotal) :
    (walk.map fun e => entry e (f e)).prod = twistTotal * phaseTotal := by
  have hsplit :
      (walk.map fun e => entry e (f e)).prod =
        (walk.map fun e => twist (f e)).prod *
          (walk.map fun e => phase e (f e)).prod := by
    clear hperm htwist hphase
    induction walk with
    | nil => simp
    | cons head tail ih =>
        rw [List.map_cons, List.prod_cons, hentry head (by simp),
          List.map_cons, List.prod_cons, List.map_cons, List.prod_cons,
          ih (fun e he => hentry e (by simp [he]))]
        ac_rfl
  have htwistReindex :
      (walk.map fun e => twist (f e)).prod = (walk.map twist).prod := by
    change (walk.map (twist ∘ f)).prod = (walk.map twist).prod
    simpa [List.map_map] using List.Perm.prod_eq (hperm.map twist)
  rw [hsplit, htwistReindex, htwist, hphase]

end Ising2DLambda.NecSuf.KacWard
