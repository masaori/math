/-
主張「特性多項式はモニックな次数 `2^L` の元である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.CharacteristicPolynomial`）の証明が実際に
使っているのは次だけである。行配位であること・格子の形・スピンの値が ±1 であること・
順序 `≺` の作り方・符号が転倒数で定まること・係数が整係数多項式であることは、
どこにも使っていない。

  使っている性質            なぜ削れないか
  `Fintype ι`               置換の全体にわたる和、添字にわたる積、`M(φ)` の個数を数えるのに要る。
  `DecidableEq ι`           `φ i = i` で場合を分け、`Equiv.Perm ι` が有限型になるのに要る。
  `Nonempty ι`              最後の一歩で `card ι - 2 < card ι` が要る。`ι` が空だと
                            `card ι = 0` で ℕ の引き算が切り詰められ、この不等式が偽になる
                            （主張自体は空の場合も真だが、この論法の形では通らない）。
  `CommSemiring S`          零元を掛けると零元、単位元を掛けても変わらない、有限和・有限積が
                            定まること。積の可換性は `∏` の記法が可換モノイドにしか定義されて
                            いないことによる。**引き算を一度も使っていないので、環である
                            必要はない。** 具体版が符号の反転を係数環の側で済ませているため、
                            多項式環の側に引き算が要らない。
  `w 1 = 1`                 恒等置換の項が積そのものになること。
  `∀ φ, DegLe (w φ) 0`      恒等でない置換の項の次数を数えるとき、係数の因子が次数を
                            上げないこと。具体版の `w = ι ∘ κ ∘ sgn` はこれを満たす。

とくに、重み `w` に要求しているのは上の 2 つだけである。すなわちこの証明は
**符号の乗法性（`claim_permutation_sign_mul`）を使っていない**。符号が `±1` であることも、
`(-1)` の冪であることも使っていない。

証明手順は具体版と同じである（恒等置換の項を括り出し、残りの各項の次数を
`|M(φ)| ≥ 2` で押さえ、モニック + 低次で結論する）。別の論法へ差し替えていない。

住処: ここに ℝ / ℂ は現れない（添字は一般の有限型、係数は一般の可換半環）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.SecondPolynomial
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.Determinant

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : Type*} [CommSemiring S]

/-- 具体版の `ch(A)` にあたる行列。符号の反転は係数環 `S` の側で済ませてある前提なので、
ここには引き算が現れない。 -/
noncomputable def charMatrix (B : ι → ι → S) (i j : ι) : Polynomial S :=
  if i = j then Polynomial.X + Polynomial.C (B i i) else Polynomial.C (B i j)

/-- 具体版の `ι(a) ∈ D_0`。 -/
theorem degLe_C (a : S) : DegLe (Polynomial.C a) 0 := by
  intro k hk
  obtain ⟨k', rfl⟩ : ∃ k', k = k' + 1 := ⟨k - 1, by omega⟩
  simp

/-- 具体版の `t + ι(a) ∈ M_1`。 -/
theorem monicDeg_X_add_C (a : S) : MonicDeg (Polynomial.X + Polynomial.C a) 1 := by
  constructor
  · intro k hk
    obtain ⟨k', rfl⟩ : ∃ k', k = k' + 1 := ⟨k - 1, by omega⟩
    rw [Polynomial.coeff_add, Polynomial.coeff_C, if_neg (by omega),
      Polynomial.coeff_X, if_neg (by omega), add_zero]
  · simp

/-- 具体版の準備の第一（恒等置換の項）。 -/
theorem monicDeg_identity_term (B : ι → ι → S) :
    MonicDeg (∏ i : ι, charMatrix B i ((1 : Equiv.Perm ι) i)) (Fintype.card ι) := by
  have hterm : ∀ i : ι, MonicDeg (charMatrix B i ((1 : Equiv.Perm ι) i)) 1 := by
    intro i
    simpa [charMatrix] using monicDeg_X_add_C (B i i)
  simpa [Finset.card_univ] using
    monicDeg_prod (T := (univ : Finset ι)) (f := fun i => charMatrix B i ((1 : Equiv.Perm ι) i))
      (n := fun _ => 1) (fun i _ => hterm i)

/-- 具体版の準備の第二（恒等写像でない置換の項）。 -/
theorem degLe_term_of_ne_one (w : Equiv.Perm ι → Polynomial S)
    (hwdeg : ∀ φ, DegLe (w φ) 0) (B : ι → ι → S)
    {φ : Equiv.Perm ι} (hφ : φ ≠ 1) :
    DegLe (w φ * ∏ i : ι, charMatrix B i (φ i)) (Fintype.card ι - 2) := by
  classical
  set n : ι → ℕ := fun i => if φ i = i then 1 else 0 with hn
  have hfactor : ∀ i ∈ (univ : Finset ι), DegLe (charMatrix B i (φ i)) (n i) := by
    intro i _
    by_cases h : φ i = i
    · simp only [hn, h, if_pos rfl]
      simpa [charMatrix, h] using (monicDeg_X_add_C (B i i)).1
    · simp only [hn, if_neg h]
      simpa [charMatrix, Ne.symm h] using degLe_C (B i (φ i))
  have hprod := degLe_prod (T := (univ : Finset ι))
    (f := fun i => charMatrix B i (φ i)) (n := n) hfactor
  have hsum : ∑ i : ι, n i
      = Fintype.card ι - (univ.filter fun i : ι => φ i ≠ i).card := by
    have hsplit : (univ.filter fun i : ι => φ i = i).card
        + (univ.filter fun i : ι => φ i ≠ i).card = Fintype.card ι := by
      simpa [Finset.card_univ] using
        Finset.filter_card_add_filter_neg_card_eq_card
          (s := (univ : Finset ι)) (p := fun i => φ i = i)
    rw [hn, ← Finset.card_filter]
    omega
  have hle : ∑ i : ι, n i ≤ Fintype.card ι - 2 := by
    have h2 := two_le_card_moved hφ
    omega
  simpa using degLe_mul (hwdeg φ) (hprod.mono hle)

/-- 「置換にわたる和で書いた `det(tI + B)` はモニックで次数は添字の個数」の必要十分版。

`w` に要求するのは `w 1 = 1` と「次数を上げないこと」だけであり、符号の乗法性も
符号であることも使わない。値の側は可換半環で足り、引き算を使わない。 -/
theorem monicDeg_charDet [Nonempty ι] (w : Equiv.Perm ι → Polynomial S)
    (hw : w 1 = 1) (hwdeg : ∀ φ, DegLe (w φ) 0) (B : ι → ι → S) :
    MonicDeg (∑ φ : Equiv.Perm ι, w φ * ∏ i : ι, charMatrix B i (φ i)) (Fintype.card ι) := by
  classical
  rw [← Finset.add_sum_erase _ _ (mem_univ (1 : Equiv.Perm ι)), hw, one_mul]
  have hpos : 0 < Fintype.card ι := Fintype.card_pos
  exact monicDeg_add_of_degLe (monicDeg_identity_term B)
    (degLe_sum fun φ hφ => degLe_term_of_ne_one w hwdeg B (Finset.ne_of_mem_erase hφ))
    (by omega)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
