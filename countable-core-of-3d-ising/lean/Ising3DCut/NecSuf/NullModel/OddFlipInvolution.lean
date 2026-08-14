/-
「奇数側だけ反転する写像は全単射である」の必要十分版。

具体版の証明で実際に使うのは、値の反転が二回で元に戻ること（対合）だけである。
値が ±1 の整数であること、反転が符号反転であること、点の側の述語が座標和の
偶奇から来ることは、いずれも証明で使っていない。

  使っている性質                            なぜ削れないか
  `f (f z) = z`（値の反転が対合であること）   これを外すと二回適用して元に戻らない
                                            （例: 定数写像 `f`）が反例になる。
  述語 `p` には何も仮定しない                 場合分けの両側が「`f` を二回当てる」か
                                            「何もしない」かになり、`p` の中身を使わないため。

証明手順は具体版と同じ（点ごとの場合分け → `funext` → 単射と全射を対合から出す）。

住処: 任意の型の上の写像のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Logic.Function.Defs
import Mathlib.Tactic.Common

namespace Ising3DCut.NecSuf.NullModel

variable {V S : Type*} (f : S → S) (p : V → Bool)

/-- 述語の成り立つ点でだけ値を `f` で置き換える写像。具体版の T の一般形。 -/
def flipOn (σ : V → S) : V → S :=
  fun a => if p a then f (σ a) else σ a

/-- 具体版 `oddFlip_oddFlip` と同じ手順。二回適用すると元に戻る。 -/
theorem flipOn_flipOn (hf : ∀ z, f (f z) = z) (σ : V → S) :
    flipOn f p (flipOn f p σ) = σ := by
  funext a
  by_cases h : p a
  · simp [flipOn, h, hf]
  · simp [flipOn, h]

/-- 具体版 `oddFlip_bijective` と同じ手順。対合だから全単射である。 -/
theorem flipOn_bijective (hf : ∀ z, f (f z) = z) :
    Function.Bijective (flipOn f p) := by
  constructor
  · intro σ τ h
    have h2 := congrArg (flipOn f p) h
    rwa [flipOn_flipOn f p hf, flipOn_flipOn f p hf] at h2
  · intro σ
    exact ⟨flipOn f p σ, flipOn_flipOn f p hf σ⟩

end Ising3DCut.NecSuf.NullModel
