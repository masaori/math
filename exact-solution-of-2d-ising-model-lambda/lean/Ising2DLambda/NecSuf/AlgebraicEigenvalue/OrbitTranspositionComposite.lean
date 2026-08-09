/-
主張「互換の反復合成は軌道の上の全単射である」の必要十分版。

具体版は `Ising2DLambda/AlgebraicEigenvalue/OrbitTranspositionComposite.lean`。
証明手順は具体版と同じ（合成についての準備 → `k` についての帰納法）であり、
仮定だけを、具体版の証明が実際に使っている性質まで落としてある。

具体版が持っていて、ここで落としたもの:

* 台が軌道であること。使っていない。台はどんな型でもよい（`α : Type*`）。
* 台が有限であること・元の相等が決定できること。使っていない。
* 順序 `≺`。使っていない。
* 合成する写像が互換であること。使っていない。各段の写像に要るのは全単射であることだけで、
  2 回合成すると恒等写像であることも、動かす点が 2 つ以下であることも使っていない。
* 写像の族が巡回シフトの反復 `S^[k]` から作られていること。使っていない。
  族は `ℕ` で添字づけられた勝手な写像の族でよい。

残した仮定と、それが必要な理由:

* `hf : ∀ k, Function.Bijective (f k)` — 帰納法の一歩で合成の相手として要る。
  1 つでも全単射でない段があれば、そこから先の合成が全単射である保証は無い。
-/
import Mathlib.Logic.Function.Basic
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*}

/-- 具体版の準備に対応する。全単射 2 つの合成は全単射である。

単射性と全射性を別々に示すのも具体版と同じである
（mathlib の `Function.Bijective.comp` は引かない）。 -/
theorem bijective_comp_of_bijective {f g : α → α}
    (hf : Function.Bijective f) (hg : Function.Bijective g) :
    Function.Bijective (fun x => g (f x)) := by
  constructor
  · intro x y hxy
    exact hf.1 (hg.1 hxy)
  · intro z
    obtain ⟨y, hy⟩ := hg.2 z
    obtain ⟨x, hx⟩ := hf.2 y
    refine ⟨x, ?_⟩
    show g (f x) = z
    rw [hx, hy]

/-- 具体版の `Ψ^{O,τ₀}_k` に対応する。写像の族 `f` の、添字 `1,…,k` の分の合成。

`Φ_0 = id`、`Φ_{k+1} = f (k+1) ∘ Φ_k`。合成の順も具体版と同じである。 -/
def compositeUpTo (f : ℕ → (α → α)) : ℕ → (α → α)
  | 0 => id
  | (k + 1) => fun x => f (k + 1) (compositeUpTo f k x)

/-- 具体版の主張に対応する。各段が全単射なら、合成も全単射である。

証明手順は具体版と同じく `k` についての帰納法である。 -/
theorem compositeUpTo_bijective (f : ℕ → (α → α))
    (hf : ∀ k, Function.Bijective (f k)) (k : ℕ) :
    Function.Bijective (compositeUpTo f k) := by
  induction k with
  | zero => exact Function.bijective_id
  | succ k ih =>
      show Function.Bijective (fun x => f (k + 1) (compositeUpTo f k x))
      exact bijective_comp_of_bijective (f := compositeUpTo f k) (g := f (k + 1)) ih (hf (k + 1))

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
