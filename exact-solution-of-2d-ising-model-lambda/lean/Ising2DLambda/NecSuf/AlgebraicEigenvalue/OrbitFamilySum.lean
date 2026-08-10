/-
主張「χ_U は軌道ごとの置換の組にわたる和である」の必要十分版。

このセクションの 3 主張のうち、`gl(res(φ)) = φ` と `res(gl(α)) = α` は、
前のセクションの必要十分版（`OrbitRestriction` の「制限の全体が置換を決めること」と
`OrbitGluing` の「貼り合わせの制限はもとの組に戻ること」）を、組の型を持ち直した形へ
書き写したものであり、新しい仮定を一つも要求しない。すなわちこのセクションで新しく
必要十分性を問うべきなのは**残る 1 段、和の添字の取り替え**だけである。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitFamilySum`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ。

  使っている性質                                    どこで
  2 つの写像が互いに逆であること                      添字の取り替えを全単射にする段
  値の側が可換な加法モノイドであること                 和を取り替える段
  取り替えた先で項が一致すること                      同上

削れなかった仮定と、その理由。

1. `hleft` と `hright`（2 つの写像が互いに逆であること）。片方だけでは全単射にならないので
   両方要る。人手証明が 2 つの主張として持っているものそのものである。
2. `hj`（`j` の値が `s` に入ること）。`i` の定義域が `s` の元に限られているので、
   これが無いと合成が書けない。人手証明の「`gl` の値が 𝔖^𝒪_L に入ること」に当たる。
3. `hfg`（取り替えた先で項が一致すること）。人手証明の最後の段
   （`gl(α)↾_O` を `α(O)` へ置き換える）に対応する。

具体版との差で言えば、次はいずれも使っていない。

* 添字が置換であること・組であること・軌道があること・順序 `≺` があること。
* 値の側が環であること・多項式であること。可換な加法モノイドで足りる。
* `s` の側の型が有限であること（`s` は Finset なので有限。取り替え先の型だけ `Fintype` を要る）。

住処: ここに ℝ / ℂ は現れない（値は一般の可換加法モノイド、添字は有限集合と有限型）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {β γ M : Type*}

/-- 互いに逆な 2 つの写像は全単射を与える。

人手証明の `res : 𝔖^𝒪_L → 𝔄_L` と `gl : 𝔄_L → 𝔖^𝒪_L` に当たる。
`i` の定義域を `s` の元に限っているのは、人手証明の `res` の定義域が
𝔖_L ではなく 𝔖^𝒪_L であることに対応する。 -/
def equivOfInverse (s : Finset β) (i : ∀ b ∈ s, γ) (j : γ → β)
    (hj : ∀ c : γ, j c ∈ s)
    (hleft : ∀ b, ∀ hb : b ∈ s, j (i b hb) = b)
    (hright : ∀ c : γ, i (j c) (hj c) = c) :
    {b : β // b ∈ s} ≃ γ where
  toFun b := i b.1 b.2
  invFun c := ⟨j c, hj c⟩
  left_inv b := Subtype.ext (hleft b.1 b.2)
  right_inv c := hright c

/-- 人手証明の主張「χ_U は軌道ごとの置換の組にわたる和である」の必要十分版。

有限集合 `s` にわたる和を、`s` と 1 対 1 に対応する有限型 `γ` にわたる和へ取り替える。
要求するのは 2 つの写像が互いに逆であることと、値の側が可換な加法モノイドであること、
そして取り替えた先で項が一致することだけである。 -/
theorem sum_eq_sum_of_inverse [Fintype γ] [AddCommMonoid M] (s : Finset β)
    (i : ∀ b ∈ s, γ) (j : γ → β)
    (hj : ∀ c : γ, j c ∈ s)
    (hleft : ∀ b, ∀ hb : b ∈ s, j (i b hb) = b)
    (hright : ∀ c : γ, i (j c) (hj c) = c)
    (f : β → M) (g : γ → M)
    (hfg : ∀ c : γ, f (j c) = g c) :
    ∑ b ∈ s, f b = ∑ c : γ, g c := by
  calc ∑ b ∈ s, f b
      = ∑ b ∈ s.attach, f b.1 := (Finset.sum_attach s f).symm
    _ = ∑ c : γ, f (j c) :=
        (Equiv.sum_comp (equivOfInverse s i j hj hleft hright).symm (fun b => f b.1)).symm
    _ = ∑ c : γ, g c := Finset.sum_congr rfl (fun c _ => hfg c)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
