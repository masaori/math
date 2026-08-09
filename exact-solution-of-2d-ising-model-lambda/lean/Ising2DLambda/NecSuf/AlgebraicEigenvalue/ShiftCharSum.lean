/-
主張「軌道を保たない置換の項は零元である」「χ_U は軌道を保つ置換にわたる、
軌道ごとの因子の積の和である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftCharSum`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ。

  使っている性質                                    どこで
  2 つの含意を対偶でつなげること                      項が零元であることの段
  値の側が可換な加法モノイドであること                 和を狭める段
  狭める先が全体の部分集合であること                   同上
  その外側で項が零元であること                        同上

削れなかった仮定と、その理由。

1. `hzero`（各点で 2 つの条件がどちらも破れていれば値が零元）と `himp`
   （各点で 2 つの条件のどちらかが成り立てば結論が成り立つ）。人手証明が
   前セクションの 2 主張として持っているものそのものである。**行列も置換も現れない**
   （`a` は 1 つの値、`P` `Q` は添字ごとの述語でしかない）。
2. `hsub`（部分集合であること）と `hout`（外側で零元であること）。
   和を狭める段はこの 2 つだけで通る。**添字が置換であることも、
   値が多項式であることも使わない**（可換な加法モノイドで足りる）。
3. `hcongr`（狭めた先で項を書き換えられること）。人手証明の最後の段
   （項の分解を和の各項へ当てる）に対応する。

具体版との差で言えば、次はいずれも使っていない。

* 値の側が環であること・多項式であること。可換な加法モノイドで足りる。
* 添字が置換であること・軌道があること・順序 `≺` があること。
* 添字の型が有限であること以外の構造（`Fintype` は `univ` を書くためだけに要る）。

住処: ここに ℝ / ℂ は現れない（値は一般の可換加法モノイド、添字は有限型）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {β M : Type*}

/-- 人手証明の主張「軌道を保たない置換の項は零元である」の必要十分版。

要求するのは 2 つの含意を対偶でつなげることだけである。
`P i` は「φ(τ) = τ」、`Q i` は「φ(τ) = S(τ)」、`H` は「φ が軌道を保つ」に当たる。
値 `a` については何も要求しない（型にも構造を要求しない）。 -/
theorem eq_zero_of_not_of_forall_or {ι : Type*} {N : Type*} {a z : N} {P Q : ι → Prop}
    {H : Prop} (hzero : ∀ i, ¬ P i → ¬ Q i → a = z)
    (himp : (∀ i, P i ∨ Q i) → H) (hH : ¬ H) : a = z := by
  classical
  -- 対偶: H が成り立たないので、各点で 2 つの条件のどちらかが成り立つことは無い。
  have hnot : ¬ ∀ i, P i ∨ Q i := fun h => hH (himp h)
  obtain ⟨i, hi⟩ := not_forall.mp hnot
  exact hzero i (fun hP => hi (Or.inl hP)) (fun hQ => hi (Or.inr hQ))

/-- 人手証明の主張「χ_U は軌道を保つ置換にわたる、軌道ごとの因子の積の和である」の必要十分版。

和を狭める段と、狭めた先で項を書き換える段の 2 つからなる。
要求するのは値の側が可換な加法モノイドであることと、部分集合の外で項が零元であることだけである。 -/
theorem sum_eq_sum_subset_congr [Fintype β] [AddCommMonoid M] (s : Finset β) (f g : β → M)
    (hout : ∀ b : β, b ∉ s → f b = 0)
    (hcongr : ∀ b ∈ s, f b = g b) :
    ∑ b : β, f b = ∑ b ∈ s, g b := by
  calc ∑ b : β, f b
      = ∑ b ∈ s, f b :=
        (Finset.sum_subset (Finset.subset_univ s) (fun b _ hb => hout b hb)).symm
    _ = ∑ b ∈ s, g b := Finset.sum_congr rfl hcongr

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
