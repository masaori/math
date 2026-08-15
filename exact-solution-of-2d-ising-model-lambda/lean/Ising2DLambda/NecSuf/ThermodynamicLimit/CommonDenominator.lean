/-
「共通分母を通した順序の判定は共通分母の取り方によらない」の必要十分版。

使うのは、`A` から `B` への単射 `toB` が正整数倍を保つこと、`B` の正整数倍が互いに可換であること、
`A` の順序が正整数倍で変わらないことだけ。素数・有理数・有限台であることは本質でない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {A B : Type*}

theorem cross_multiple_order_independent_necSuf
    (smulA : ℕ → A → A) (smulB : ℕ → B → B) (toB : A → B) (leA : A → A → Prop)
    (hinj : ∀ a a' : A, toB a = toB a' → a = a')
    (hmap : ∀ n a, toB (smulA n a) = smulB n (toB a))
    (hcomm : ∀ n n' b, smulB n (smulB n' b) = smulB n' (smulB n b))
    (hinv : ∀ n, 1 ≤ n → ∀ a a' : A, leA a a' ↔ leA (smulA n a) (smulA n a'))
    (N N' : ℕ) (hN : 1 ≤ N) (hN' : 1 ≤ N')
    (l m : B) (lN mN lN' mN' : A)
    (hl : smulB N l = toB lN) (hm : smulB N m = toB mN)
    (hl' : smulB N' l = toB lN') (hm' : smulB N' m = toB mN') :
    leA lN mN ↔ leA lN' mN' := by
  -- 準備: N'λ_N = Nλ_{N'}（ι で送って比べ、単射性で戻す）
  have cross : ∀ (b : B) (aN aN' : A), smulB N b = toB aN → smulB N' b = toB aN' →
      smulA N' aN = smulA N aN' := by
    intro b aN aN' h h'
    apply hinj
    calc
      toB (smulA N' aN) = smulB N' (toB aN) := hmap _ _
      _ = smulB N' (smulB N b) := by rw [← h]
      _ = smulB N (smulB N' b) := hcomm _ _ _
      _ = smulB N (toB aN') := by rw [h']
      _ = toB (smulA N aN') := (hmap _ _).symm
  have el := cross l lN lN' hl hl'
  have em := cross m mN mN' hm hm'
  calc
    leA lN mN ↔ leA (smulA N' lN) (smulA N' mN) := hinv N' hN' lN mN
    _ ↔ leA (smulA N lN') (smulA N mN') := by rw [el, em]
    _ ↔ leA lN' mN' := (hinv N hN lN' mN').symm

end Ising2DLambda.NecSuf.ThermodynamicLimit
