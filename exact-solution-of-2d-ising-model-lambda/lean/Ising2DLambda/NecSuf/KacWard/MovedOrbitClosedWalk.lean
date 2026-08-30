/-
必要十分版: 単射な自己写像 f と関係 R について、動く点で R が成り立つなら、
動く点 x の反復列は R で連鎖し、回帰時刻の最小性の下で相異なる。

使う構造は f の単射性、反復合成、自然数の比較だけである。
有限性・全射性・格子・辺の構造は不要と分かった。
-/
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 人手証明の第一の主張: 動く点の反復はすべて動く点である（単射性の移送）。 -/
theorem moved_iterate_ne {α : Type} {f : α → α} (hf : Function.Injective f)
    {x : α} (hx : f x ≠ x) : ∀ k, f (f^[k] x) ≠ f^[k] x := by
  intro k
  induction k with
  | zero => simpa using hx
  | succ k ih =>
    intro h
    rw [Function.iterate_succ_apply'] at h
    exact ih (hf h)

/-- 人手証明の第二の主張の隣接接続: 各反復は関係 R で次の反復へつながる。 -/
theorem orbit_relation_chain {α : Type} {f : α → α} (hf : Function.Injective f)
    {R : α → α → Prop} (hR : ∀ a, f a ≠ a → R a (f a))
    {x : α} (hx : f x ≠ x) : ∀ k, R (f^[k] x) (f^[k + 1] x) := by
  intro k
  have h := hR (f^[k] x) (moved_iterate_ne hf hx k)
  simpa [Function.iterate_succ_apply'] using h

/-- 人手証明の第三の主張: 回帰時刻の最小性の下で、反復列は相異なる。 -/
theorem orbit_iterates_distinct {α : Type} {f : α → α} (hf : Function.Injective f)
    {x : α} {r : ℕ} (hmin : ∀ k, 1 ≤ k → k < r → f^[k] x ≠ x) :
    ∀ j l, j < l → l < r → f^[j] x ≠ f^[l] x := by
  intro j l hjl hlr h
  have hsplit : f^[j] (f^[l - j] x) = f^[l] x := by
    rw [← Function.iterate_add_apply]
    congr 1
    omega
  have hx0 : f^[l - j] x = x := (hf.iterate j) (by rw [hsplit, ← h])
  exact hmin (l - j) (by omega) (by omega) hx0

end Ising2DLambda.NecSuf.KacWard
