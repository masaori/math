/-
「対角相似による反対称化」の具体版。
本文の重みの六等号と指数型変換、方向位相の十六通りの表、長項・短項の符号反転、
定数埋込みを通した二寄与の合成を独立に計算する。必要十分版は呼ばない。
係数は Qbar、指数は ℤ、最終成分は Polynomial Qbar に属する。
零対角は反転の固定点不在と接続条件だけから導き、四乗根の条件を使わない。
-/
import Ising2DLambda.KacWard.GaugedTerminalMatrix
import Ising2DLambda.KacWard.TwistSignParity

namespace Ising2DLambda.KacWard
open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の補助位相 R。反転方向からの三種類の許された回転以外へ零を割り当てる。 -/
noncomputable def gaugeDirectionPhase (z : Qbar) (a b : ZMod 4) : Qbar :=
  if b = a + 2 then 1 else if b = a + 3 then z else if b = a + 1 then z⁻¹ else 0

/-- 本文の σ。整数方向代表の順序を係数の符号へ送る。 -/
noncomputable def gaugeDirectionSign (a b : ZMod 4) : Qbar :=
  if a.val < b.val then 1 else if b.val < a.val then -1 else 0

lemma gaugeDirectionSign_skew (a b : ZMod 4) :
    gaugeDirectionSign a b = -gaugeDirectionSign b a := by
  by_cases hab : a.val < b.val
  · simp [gaugeDirectionSign, hab, Nat.not_lt_of_ge (Nat.le_of_lt hab)]
  · by_cases hba : b.val < a.val
    · simp [gaugeDirectionSign, hab, hba]
    · simp [gaugeDirectionSign, hab, hba]

/-- 実際の反転辺の方向を、本文の補助位相へ置き換える。 -/
lemma rotationPhase_reversal_eq_directionPhase {L : ℕ} (z : Qbar)
    (e f : OrientedEdge L) :
    rotationPhase z (reversal e) f = gaugeDirectionPhase z (directionNumber e) (directionNumber f) := by
  unfold rotationPhase gaugeDirectionPhase
  rw [directionNumber_reversal]
  have hplus : directionNumber e + 2 + 1 = directionNumber e + 3 := by ring
  have hminus : directionNumber e + 2 - 1 = directionNumber e + 1 := by ring
  rw [hplus, hminus]

/-- 本文の方向表を全十六通りで展開する。対角の零も含む。 -/
lemma gaugeDirectionPhase_table (z : Qbar) (a b : ZMod 4) :
    gaugeDirectionPhase z a b = if a = b then 0 else
      z ^ (if a.val < b.val then -2 - (a.val : ℤ) + b.val else 2 - (a.val : ℤ) + b.val) := by
  fin_cases a <;> fin_cases b <;>
    first | rfl | exact (zpow_neg_one z).symm | exact (zpow_zero z).symm | exact (zpow_one z).symm

/-- 上三角では二つの指数の和が零、下三角では四となる計算。 -/
lemma gaugeDirectionPhase_weighted (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (a b : ZMod 4) :
    z ^ (2 + (a.val : ℤ) - b.val) * gaugeDirectionPhase z a b =
      gaugeDirectionSign a b := by
  have hnz := diagonalGauge_root_ne_zero z hz
  unfold gaugeDirectionSign
  by_cases heq : a = b
  · have hlt : ¬a.val < b.val := by rw [heq]; exact lt_irrefl _
    have hgt : ¬b.val < a.val := by rw [heq]; exact lt_irrefl _
    rw [if_neg hlt, if_neg hgt]
    calc
      z ^ (2 + (a.val : ℤ) - b.val) * gaugeDirectionPhase z a b =
          z ^ (2 + (a.val : ℤ) - b.val) * 0 := by rw [gaugeDirectionPhase_table, if_pos heq]
      _ = 0 := mul_zero _
  · by_cases hab : a.val < b.val
    · rw [if_pos hab]
      calc
        z ^ (2 + (a.val : ℤ) - b.val) * gaugeDirectionPhase z a b =
            z ^ (2 + (a.val : ℤ) - b.val) * z ^ (-2 - (a.val : ℤ) + b.val) := by
          rw [gaugeDirectionPhase_table, if_neg heq, if_pos hab]
        _ = z ^ ((2 + (a.val : ℤ) - b.val) + (-2 - (a.val : ℤ) + b.val)) :=
          (zpow_add₀ hnz _ _).symm
        _ = z ^ (0 : ℤ) := by congr 1; ring
        _ = 1 := zpow_zero z
    · have hba : b.val < a.val := by
        have hne : a.val ≠ b.val := by
          intro h
          exact heq (ZMod.val_injective 4 h)
        omega
      rw [if_neg hab, if_pos hba]
      calc
        z ^ (2 + (a.val : ℤ) - b.val) * gaugeDirectionPhase z a b =
            z ^ (2 + (a.val : ℤ) - b.val) * z ^ (2 - (a.val : ℤ) + b.val) := by
          rw [gaugeDirectionPhase_table, if_neg heq, if_neg hab]
        _ = z ^ ((2 + (a.val : ℤ) - b.val) + (2 - (a.val : ℤ) + b.val)) :=
          (zpow_add₀ hnz _ _).symm
        _ = z ^ (4 : ℤ) := by congr 1; ring
        _ = z ^ (4 : ℕ) := zpow_natCast z 4
        _ = -1 := hz

/-- 切断線の指示子は辺の番号だけに依存し、向きの反転で変わらない。 -/
lemma twistParity_reversal {L : ℕ} (s : SpinStructure) (e : OrientedEdge L) :
    twistParity s (reversal e) = twistParity s e := rfl

/-- 本文の重みの六等号に指数型変換を加え、定義・四回の冪結合・指数整理を分ける。 -/
lemma gaugePairWeight_zpow {L : ℕ} (z : Qbar) (hnz : z ≠ 0)
    (s : SpinStructure) (e f : OrientedEdge L) :
    gaugePairWeight z s e f = z ^ (2 + directionStandardRepresentative (directionNumber e) -
      directionStandardRepresentative (directionNumber f) + 2 * (twistParity s e : ℤ) -
      2 * (twistParity s f : ℤ)) := by
  let r := directionStandardRepresentative (directionNumber e)
  let t := directionStandardRepresentative (directionNumber f)
  let k : ℤ := twistParity s e
  let l : ℤ := twistParity s f
  calc
    gaugePairWeight z s e f =
        z ^ (2 : ℕ) * ((z ^ (2 * k) * z ^ r) * (z ^ (-t) * z ^ (-2 * l))) := by
      simp only [gaugePairWeight, diagonalGaugeInverseWeight, diagonalGaugeWeight,
        directionGaugeExponent, twistGaugeExponent, neg_neg, neg_mul, r, t, k, l]
    _ = z ^ (2 : ℤ) * ((z ^ (2 * k) * z ^ r) * (z ^ (-t) * z ^ (-2 * l))) := by
      exact congrArg (fun v => v * ((z ^ (2 * k) * z ^ r) * (z ^ (-t) * z ^ (-2 * l))))
        (zpow_natCast z 2).symm
    _ = z ^ (2 : ℤ) * (z ^ (2 * k + r) * (z ^ (-t) * z ^ (-2 * l))) := by
      rw [← zpow_add₀ hnz (2 * k) r]
    _ = z ^ (2 : ℤ) * (z ^ (2 * k + r) * z ^ (-t + -2 * l)) := by
      rw [← zpow_add₀ hnz (-t) (-2 * l)]
    _ = z ^ (2 : ℤ) * z ^ ((2 * k + r) + (-t + -2 * l)) := by
      rw [← zpow_add₀ hnz (2 * k + r) (-t + -2 * l)]
    _ = z ^ (2 + ((2 * k + r) + (-t + -2 * l))) := by
      rw [← zpow_add₀ hnz]
    _ = z ^ (2 + r - t + 2 * k - 2 * l) := by congr 1; ring

/-- 整数の符号を係数へ送り、四乗根の条件から整数指数に直す五等号。 -/
lemma twistSign_cast_eq_zpow {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : OrientedEdge L) :
    (twistSign s e : Qbar) = z ^ (4 * (twistParity s e : ℤ)) := by
  calc
    (twistSign s e : Qbar) = ((-1 : ℤ) ^ twistParity s e : ℤ) := by
      rw [twistSign_eq_neg_one_pow_twistParity]
    _ = (-1 : Qbar) ^ twistParity s e := by push_cast; rfl
    _ = (z ^ (4 : ℕ)) ^ twistParity s e := by rw [hz]
    _ = z ^ (4 * twistParity s e) := (pow_mul _ _ _).symm
    _ = z ^ (4 * (twistParity s e : ℤ)) := by rw [← zpow_natCast]; norm_num

/-- 長項では反転による偶奇の不変性を代入し、残る方向の指数を零または四にする。 -/
lemma gaugePairWeight_reversal {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : OrientedEdge L) :
    gaugePairWeight z s e (reversal e) =
      if (directionNumber e).val < 2 then 1 else -1 := by
  have hnz := diagonalGauge_root_ne_zero z hz
  have hdir (d : ZMod 4) :
      2 + directionStandardRepresentative d - directionStandardRepresentative (d + 2) =
        if d.val < 2 then 0 else 4 := by
    fin_cases d <;> decide
  calc
    gaugePairWeight z s e (reversal e) = z ^ (2 + directionStandardRepresentative (directionNumber e) -
        directionStandardRepresentative (directionNumber (reversal e)) + 2 * (twistParity s e : ℤ) -
        2 * (twistParity s (reversal e) : ℤ)) := gaugePairWeight_zpow z hnz s e (reversal e)
    _ = z ^ (2 + directionStandardRepresentative (directionNumber e) -
        directionStandardRepresentative (directionNumber (reversal e)) + 2 * (twistParity s e : ℤ) -
        2 * (twistParity s e : ℤ)) := by rw [twistParity_reversal]
    _ = z ^ (2 + directionStandardRepresentative (directionNumber e) -
        directionStandardRepresentative (directionNumber (reversal e))) := by congr 1; ring
    _ = z ^ (2 + directionStandardRepresentative (directionNumber e) -
        directionStandardRepresentative (directionNumber e + 2)) := by rw [directionNumber_reversal]
    _ = z ^ (if (directionNumber e).val < 2 then (0 : ℤ) else 4) := by rw [hdir]
    _ = if (directionNumber e).val < 2 then 1 else -1 := by
      split_ifs <;> first | exact zpow_zero z | exact (zpow_natCast z 4).trans hz

/-- 長項の条件は対合性から対称であり、方向を二進めると係数の符号が反転する。 -/
lemma gaugeLongCoefficient_skew {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e f : OrientedEdge L) :
    (if f = reversal e then gaugePairWeight z s e f else 0) =
      -(if e = reversal f then gaugePairWeight z s f e else 0) := by
  have hcond : f = reversal e ↔ e = reversal f := by
    constructor
    · intro h
      rw [h, reversal_involutive]
    · intro h
      rw [h, reversal_involutive]
  by_cases hfe : f = reversal e
  · subst f
    rw [if_pos rfl, if_pos (reversal_involutive e).symm]
    have hback : gaugePairWeight z s (reversal e) e =
        if (directionNumber (reversal e)).val < 2 then 1 else -1 := by
      simpa only [reversal_involutive] using gaugePairWeight_reversal z hz s (reversal e)
    rw [gaugePairWeight_reversal z hz s e, hback, directionNumber_reversal]
    generalize directionNumber e = d
    fin_cases d <;> first | exact (neg_neg (1 : Qbar)).symm | rfl
  · rw [if_neg hfe, if_neg (fun h => hfe (hcond.mpr h)), neg_zero]

/-- 短項は二つの偶奇の和による共通因子と、方向の順序だけによる符号へ分かれる。 -/
lemma gaugeShortCoefficient_value {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e f : OrientedEdge L) :
    gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) =
      gaugeDirectionSign (directionNumber e) (directionNumber f) *
        z ^ (2 * ((twistParity s e : ℤ) + (twistParity s f : ℤ))) := by
  have hnz := diagonalGauge_root_ne_zero z hz
  let r : ℤ := (directionNumber e).val
  let t : ℤ := (directionNumber f).val
  let k : ℤ := twistParity s e
  let l : ℤ := twistParity s f
  let R := gaugeDirectionPhase z (directionNumber e) (directionNumber f)
  calc
    gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) =
        z ^ (2 + r - t + 2 * k - 2 * l) *
          ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) := by
      rw [gaugePairWeight_zpow z hnz]
      rfl
    _ = z ^ (2 + r - t + 2 * k - 2 * l) * (z ^ (4 * l) * rotationPhase z (reversal e) f) := by
      rw [twistSign_cast_eq_zpow z hz]
    _ = z ^ (2 + r - t + 2 * k - 2 * l) * (z ^ (4 * l) * R) := by
      rw [rotationPhase_reversal_eq_directionPhase]
    _ = (z ^ (2 + r - t + 2 * k - 2 * l) * z ^ (4 * l)) * R := (mul_assoc _ _ _).symm
    _ = z ^ ((2 + r - t + 2 * k - 2 * l) + 4 * l) * R := by rw [← zpow_add₀ hnz]
    _ = z ^ ((2 + r - t) + 2 * (k + l)) * R := by congr 2; ring
    _ = (z ^ (2 + r - t) * z ^ (2 * (k + l))) * R := by rw [zpow_add₀ hnz]
    _ = z ^ (2 + r - t) * (z ^ (2 * (k + l)) * R) := mul_assoc _ _ _
    _ = z ^ (2 + r - t) * (R * z ^ (2 * (k + l))) := by rw [mul_comm (z ^ (2 * (k + l))) R]
    _ = (z ^ (2 + r - t) * R) * z ^ (2 * (k + l)) := (mul_assoc _ _ _).symm
    _ = gaugeDirectionSign (directionNumber e) (directionNumber f) *
        z ^ (2 * (k + l)) := by rw [gaugeDirectionPhase_weighted z hz]

/-- 本文の短係数交換の五等号。方向順序の符号と偶奇和を別々に交換する。 -/
lemma gaugeShortScalarCoefficient_skew {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e f : OrientedEdge L) :
    gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) =
      -(gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e)) := by
  calc
    gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) =
        gaugeDirectionSign (directionNumber e) (directionNumber f) *
          z ^ (2 * ((twistParity s e : ℤ) + (twistParity s f : ℤ))) :=
      gaugeShortCoefficient_value z hz s e f
    _ = (-gaugeDirectionSign (directionNumber f) (directionNumber e)) *
        z ^ (2 * ((twistParity s e : ℤ) + (twistParity s f : ℤ))) := by
      rw [gaugeDirectionSign_skew (directionNumber e) (directionNumber f)]
    _ = -(gaugeDirectionSign (directionNumber f) (directionNumber e) *
        z ^ (2 * ((twistParity s e : ℤ) + (twistParity s f : ℤ)))) := neg_mul _ _
    _ = -(gaugeDirectionSign (directionNumber f) (directionNumber e) *
        z ^ (2 * ((twistParity s f : ℤ) + (twistParity s e : ℤ)))) := by
      rw [add_comm (twistParity s e : ℤ) (twistParity s f : ℤ)]
    _ = -(gaugePairWeight z s f e *
        ((twistSign s e : Qbar) * rotationPhase z (reversal f) e)) := by
      rw [gaugeShortCoefficient_value z hz s f e]

/-- 始点と相異性の条件を交換し、共通因子を保ったまま方向順序の符号を反転する。 -/
lemma gaugeShortCoefficient_skew {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e f : OrientedEdge L) :
    (if orientedSource f = orientedSource e ∧ f ≠ e then
      gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) =
      -(if orientedSource e = orientedSource f ∧ e ≠ f then
        gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0) := by
  have hcond : (orientedSource f = orientedSource e ∧ f ≠ e) ↔
      (orientedSource e = orientedSource f ∧ e ≠ f) := by
    constructor <;> rintro ⟨hsrc, hne⟩ <;> exact ⟨hsrc.symm, Ne.symm hne⟩
  by_cases h : orientedSource f = orientedSource e ∧ f ≠ e
  · rw [if_pos h, if_pos (hcond.mp h)]
    exact gaugeShortScalarCoefficient_skew z hz s e f
  · rw [if_neg h, if_neg (fun hh => h (hcond.mpr hh)), neg_zero]

/-- 成分公式を長項と短項に分配し、定数埋込みの積の保存を各場合で適用する。 -/
lemma gaugedTerminalMatrix_entry_separated (L : ℕ) [NeZero L] (z : Qbar)
    (s : SpinStructure) (e f : OrientedEdge L) :
    gaugedTerminalMatrix L z s e f =
      qbarConst (if f = reversal e then gaugePairWeight z s e f else 0) - Polynomial.X *
        qbarConst (if orientedSource f = orientedSource e ∧ f ≠ e then
          gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) := by
  let w := gaugePairWeight z s e f
  let a := (twistSign s f : Qbar) * rotationPhase z (reversal e) f
  have hlong : qbarConst w * (if f = reversal e then 1 else 0) =
      qbarConst (if f = reversal e then w else 0) := by
    by_cases h : f = reversal e
    · calc
        qbarConst w * (if f = reversal e then 1 else 0) = qbarConst w * 1 := by rw [if_pos h]
        _ = qbarConst w := mul_one _
        _ = qbarConst (if f = reversal e then w else 0) := by rw [if_pos h]
    · calc
        qbarConst w * (if f = reversal e then 1 else 0) = qbarConst w * 0 := by rw [if_neg h]
        _ = 0 := mul_zero _
        _ = qbarConst 0 := Polynomial.C_0.symm
        _ = qbarConst (if f = reversal e then w else 0) := by rw [if_neg h]
  have hshort : qbarConst w * (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0) =
      qbarConst (if orientedSource f = orientedSource e ∧ f ≠ e then w * a else 0) := by
    by_cases h : orientedSource f = orientedSource e ∧ f ≠ e
    · calc
        qbarConst w * (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0) =
            qbarConst w * qbarConst a := by rw [if_pos h]
        _ = qbarConst (w * a) := Polynomial.C_mul.symm
        _ = qbarConst (if orientedSource f = orientedSource e ∧ f ≠ e then w * a else 0) := by rw [if_pos h]
    · calc
        qbarConst w * (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0) =
            qbarConst w * 0 := by rw [if_neg h]
        _ = 0 := mul_zero _
        _ = qbarConst 0 := Polynomial.C_0.symm
        _ = qbarConst (if orientedSource f = orientedSource e ∧ f ≠ e then w * a else 0) := by rw [if_neg h]
  calc
    gaugedTerminalMatrix L z s e f = qbarConst w *
        ((if f = reversal e then 1 else 0) - Polynomial.X *
          (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0)) :=
      gaugedTerminalMatrix_entry L z s e f
    _ = qbarConst w * (if f = reversal e then 1 else 0) -
        qbarConst w * (Polynomial.X *
          (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0)) := mul_sub _ _ _
    _ = qbarConst w * (if f = reversal e then 1 else 0) -
        (qbarConst w * Polynomial.X) *
          (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0) := by
      rw [mul_assoc]
    _ = qbarConst w * (if f = reversal e then 1 else 0) -
        (Polynomial.X * qbarConst w) *
          (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0) := by
      rw [mul_comm (qbarConst w) Polynomial.X]
    _ = qbarConst w * (if f = reversal e then 1 else 0) -
        Polynomial.X * (qbarConst w *
          (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0)) := by
      rw [mul_assoc]
    _ = qbarConst (if f = reversal e then w else 0) -
        Polynomial.X * (qbarConst w *
          (if orientedSource f = orientedSource e ∧ f ≠ e then qbarConst a else 0)) := by rw [hlong]
    _ = _ := by rw [hshort]

/-- 本文の最終鎖。二つの係数の符号を一つずつ移し、成分全体の負号へまとめる。 -/
theorem gaugedTerminalMatrix_skew (L : ℕ) [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (e f : OrientedEdge L) :
    gaugedTerminalMatrix L z s e f = -gaugedTerminalMatrix L z s f e := by
  calc
    gaugedTerminalMatrix L z s e f =
        qbarConst (if f = reversal e then gaugePairWeight z s e f else 0) - Polynomial.X *
          qbarConst (if orientedSource f = orientedSource e ∧ f ≠ e then
            gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) :=
      gaugedTerminalMatrix_entry_separated L z s e f
    _ = qbarConst (-(if e = reversal f then gaugePairWeight z s f e else 0)) - Polynomial.X *
          qbarConst (if orientedSource f = orientedSource e ∧ f ≠ e then
            gaugePairWeight z s e f * ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) := by
      rw [gaugeLongCoefficient_skew z hz]
    _ = qbarConst (-(if e = reversal f then gaugePairWeight z s f e else 0)) - Polynomial.X *
          qbarConst (-(if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0)) := by
      rw [gaugeShortCoefficient_skew z hz]
    _ = -(qbarConst (if e = reversal f then gaugePairWeight z s f e else 0)) - Polynomial.X *
          qbarConst (-(if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0)) := by
      rw [show ∀ a : Qbar, qbarConst (-a) = -qbarConst a from fun _ => Polynomial.C_neg]
    _ = -(qbarConst (if e = reversal f then gaugePairWeight z s f e else 0)) - Polynomial.X * -(qbarConst (if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0)) := by
      rw [show ∀ a : Qbar, qbarConst (-a) = -qbarConst a from fun _ => Polynomial.C_neg]
    _ = -(qbarConst (if e = reversal f then gaugePairWeight z s f e else 0)) - -(Polynomial.X * qbarConst (if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0)) := by rw [mul_neg]
    _ = -(qbarConst (if e = reversal f then gaugePairWeight z s f e else 0)) + -(-(Polynomial.X * qbarConst (if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0))) := sub_eq_add_neg _ _
    _ = -(qbarConst (if e = reversal f then gaugePairWeight z s f e else 0) + -(Polynomial.X * qbarConst (if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0))) := (neg_add _ _).symm
    _ = -(qbarConst (if e = reversal f then gaugePairWeight z s f e else 0) - Polynomial.X * qbarConst (if orientedSource e = orientedSource f ∧ e ≠ f then
            gaugePairWeight z s f e * ((twistSign s e : Qbar) * rotationPhase z (reversal f) e) else 0)) := by rw [sub_eq_add_neg]
    _ = -gaugedTerminalMatrix L z s f e := by rw [gaugedTerminalMatrix_entry_separated]

/-- 本文の零対角の六等号。反対称性から二で割る操作は使わない。 -/
theorem gaugedTerminalMatrix_diagonal_zero (L : ℕ) [NeZero L] (z : Qbar)
    (s : SpinStructure) (e : OrientedEdge L) : gaugedTerminalMatrix L z s e e = 0 := by
  calc
    gaugedTerminalMatrix L z s e e = qbarConst (gaugePairWeight z s e e) *
        ((if e = reversal e then 1 else 0) - Polynomial.X *
          (if orientedSource e = orientedSource e ∧ e ≠ e then
            Polynomial.C ((twistSign s e : Qbar) * rotationPhase z (reversal e) e) else 0)) :=
      gaugedTerminalMatrix_entry L z s e e
    _ = qbarConst (gaugePairWeight z s e e) * (0 - Polynomial.X *
          (if orientedSource e = orientedSource e ∧ e ≠ e then
            Polynomial.C ((twistSign s e : Qbar) * rotationPhase z (reversal e) e) else 0)) := by
      rw [if_neg (Ne.symm (reversal_ne e))]
    _ = qbarConst (gaugePairWeight z s e e) * (0 - Polynomial.X * 0) := by
      rw [if_neg (fun h => h.2 rfl)]
    _ = qbarConst (gaugePairWeight z s e e) * (0 - 0) := by rw [mul_zero]
    _ = qbarConst (gaugePairWeight z s e e) * 0 := by rw [sub_zero]
    _ = 0 := mul_zero _

end Ising2DLambda.KacWard
