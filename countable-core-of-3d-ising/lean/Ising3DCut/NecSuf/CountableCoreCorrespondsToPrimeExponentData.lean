/-
二つの衝突を持たない写像の像が一対一に対応するために必要十分な構造だけを残す。

正の有理数・素数・付値・順序・代数構造は使わない。必要なのは、対象となる元を
指定する述語と、その対象上で元を区別する二つの写像だけである。具体版と同じ六段を辿る。
-/
import Ising3DCut.NecSuf.SufficientCoarseGrainingAdmitsALeftInverse

namespace Ising3DCut.NecSuf

variable {A S T : Type*}

/-- 人手証明の第二段。復元後に元の写像を適用すると像の元へ戻る。 -/
theorem good_image_section (Good : A → Prop) (π : A → S) (s : goodImage Good π) :
    π (goodLeftInverse Good π s) = s.val :=
  (goodLeftInverse_spec Good π s).2

/-- 人手証明の第四段の前半。一方の像から他方の像へ送る写像。 -/
noncomputable def goodImageToGoodImage (Good : A → Prop) (π : A → S) (lam : A → T)
    (s : goodImage Good π) : goodImage Good lam :=
  toGoodImage Good lam (goodLeftInverse Good π s) (goodLeftInverse_spec Good π s).1

/-- 人手証明の第四段の後半。他方の像から一方の像へ送る写像。 -/
noncomputable def goodImageFromGoodImage (Good : A → Prop) (π : A → S) (lam : A → T)
    (t : goodImage Good lam) : goodImage Good π :=
  toGoodImage Good π (goodLeftInverse Good lam t) (goodLeftInverse_spec Good lam t).1

/-- 人手証明の第五段。一方の像上の合成は恒等である。 -/
theorem goodImageFromGoodImage_goodImageToGoodImage (Good : A → Prop) (π : A → S) (lam : A → T)
    (hπ : ∀ a b, Good a → Good b → π a = π b → a = b)
    (hlam : ∀ a b, Good a → Good b → lam a = lam b → a = b)
    (s : goodImage Good π) :
    goodImageFromGoodImage Good π lam (goodImageToGoodImage Good π lam s) = s := by
  apply Subtype.ext
  show π (goodLeftInverse Good lam (goodImageToGoodImage Good π lam s)) = s.val
  have hleft : goodLeftInverse Good lam (goodImageToGoodImage Good π lam s)
      = goodLeftInverse Good π s :=
    goodLeftInverse_leftInverse Good lam hlam _ (goodLeftInverse_spec Good π s).1
  rw [hleft, good_image_section Good π s]

/-- 人手証明の第六段。他方の像上の合成は恒等である。 -/
theorem goodImageToGoodImage_goodImageFromGoodImage (Good : A → Prop) (π : A → S) (lam : A → T)
    (hπ : ∀ a b, Good a → Good b → π a = π b → a = b)
    (hlam : ∀ a b, Good a → Good b → lam a = lam b → a = b)
    (t : goodImage Good lam) :
    goodImageToGoodImage Good π lam (goodImageFromGoodImage Good π lam t) = t := by
  apply Subtype.ext
  show lam (goodLeftInverse Good π (goodImageFromGoodImage Good π lam t)) = t.val
  have hleft : goodLeftInverse Good π (goodImageFromGoodImage Good π lam t)
      = goodLeftInverse Good lam t :=
    goodLeftInverse_leftInverse Good π hπ _ (goodLeftInverse_spec Good lam t).1
  rw [hleft, good_image_section Good lam t]

/-- 六段を束ねる。対象上で単射な二写像の像は互いに逆な写像で対応する。 -/
theorem good_images_correspond (Good : A → Prop) (π : A → S) (lam : A → T)
    (hπ : ∀ a b, Good a → Good b → π a = π b → a = b)
    (hlam : ∀ a b, Good a → Good b → lam a = lam b → a = b) :
    ∃ (Φ : goodImage Good π → goodImage Good lam)
      (Ψ : goodImage Good lam → goodImage Good π),
      (∀ s, Ψ (Φ s) = s) ∧ (∀ t, Φ (Ψ t) = t) :=
  ⟨goodImageToGoodImage Good π lam, goodImageFromGoodImage Good π lam,
    goodImageFromGoodImage_goodImageToGoodImage Good π lam hπ hlam,
    goodImageToGoodImage_goodImageFromGoodImage Good π lam hπ hlam⟩

end Ising3DCut.NecSuf
