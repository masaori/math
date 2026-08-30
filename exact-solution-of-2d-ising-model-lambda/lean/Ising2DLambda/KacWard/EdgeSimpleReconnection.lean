/-
「台の辺が相異なる閉歩道の出辺交換は非後退接続を与える」の具体版。
人手証明と同じく、向き付き辺を（台の辺, 向き）の対で持ち、添字 a の通過の接続を
src (edge (σ a)) = tgt (edge a) で持つ。
(1) 始点と終点の一致は、添字 l（対称に k）の通過の接続と通過の頂点の共有から、
(2) 反転の回避は、台の辺の相異性（hinj）と向きの二値性（hd）から
    必要十分版 reversal_avoidance_necSuf で示す。
人手証明が k ↔ l の入れ替えで対称に済ませる二本目も、同じ二段をそのまま書く。
-/
import Ising2DLambda.NecSuf.KacWard.EdgeSimpleReconnection

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem edgeSimpleReconnectionNonbacktracking {U V : Type}
    (edge : ℕ → U × ℤ) (src tgt : U × ℤ → V) (σ : ℕ → ℕ) (m k l : ℕ)
    (hd : ∀ a, 1 ≤ a → a ≤ m → (edge a).2 = 0 ∨ (edge a).2 = 1)
    (hinj : ∀ a b, 1 ≤ a → a ≤ m → 1 ≤ b → b ≤ m →
      (edge a).1 = (edge b).1 → a = b)
    (hσ : ∀ a, 1 ≤ a → a ≤ m → 1 ≤ σ a ∧ σ a ≤ m)
    (hadj : ∀ a, 1 ≤ a → a ≤ m → src (edge (σ a)) = tgt (edge a))
    (hk : 1 ≤ k ∧ k ≤ m) (hl : 1 ≤ l ∧ l ≤ m)
    (hvertex : tgt (edge k) = tgt (edge l)) :
    (src (edge (σ l)) = tgt (edge k) ∧
      edge (σ l) ≠ ((edge k).1, 1 - (edge k).2)) ∧
    (src (edge (σ k)) = tgt (edge l) ∧
      edge (σ k) ≠ ((edge l).1, 1 - (edge l).2)) := by
  have hσl := hσ l hl.1 hl.2
  have hσk := hσ k hk.1 hk.2
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · -- src(e_{σ(l)}) = tgt(e_l) = tgt(e_k)
    exact (hadj l hl.1 hl.2).trans hvertex.symm
  · -- e_{σ(l)} ≠ ι(e_k): 台の辺の一致から σ(l) = k、対の一致が従う
    exact reversal_avoidance_necSuf (edge k) (edge (σ l)) (hd k hk.1 hk.2)
      (fun h1 => by rw [hinj (σ l) k hσl.1 hσl.2 hk.1 hk.2 h1])
  · -- src(e_{σ(k)}) = tgt(e_k) = tgt(e_l)
    exact (hadj k hk.1 hk.2).trans hvertex
  · -- e_{σ(k)} ≠ ι(e_l): 同じ二段を k ↔ l で
    exact reversal_avoidance_necSuf (edge l) (edge (σ k)) (hd l hl.1 hl.2)
      (fun h1 => by rw [hinj (σ k) l hσk.1 hσk.2 hl.1 hl.2 h1])

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem edgeSimpleReconnectionNonbacktracking_from_necSuf {U V : Type}
    (edge : ℕ → U × ℤ) (src tgt : U × ℤ → V) (σ : ℕ → ℕ) (m k l : ℕ)
    (hd : ∀ a, 1 ≤ a → a ≤ m → (edge a).2 = 0 ∨ (edge a).2 = 1)
    (hinj : ∀ a b, 1 ≤ a → a ≤ m → 1 ≤ b → b ≤ m →
      (edge a).1 = (edge b).1 → a = b)
    (hσ : ∀ a, 1 ≤ a → a ≤ m → 1 ≤ σ a ∧ σ a ≤ m)
    (hadj : ∀ a, 1 ≤ a → a ≤ m → src (edge (σ a)) = tgt (edge a))
    (hk : 1 ≤ k ∧ k ≤ m) (hl : 1 ≤ l ∧ l ≤ m)
    (hvertex : tgt (edge k) = tgt (edge l)) :
    (src (edge (σ l)) = tgt (edge k) ∧
      edge (σ l) ≠ ((edge k).1, 1 - (edge k).2)) ∧
    (src (edge (σ k)) = tgt (edge l) ∧
      edge (σ k) ≠ ((edge l).1, 1 - (edge l).2)) :=
  edgeSimpleReconnectionNonbacktracking edge src tgt σ m k l
    hd hinj hσ hadj hk hl hvertex

end Ising2DLambda.KacWard
